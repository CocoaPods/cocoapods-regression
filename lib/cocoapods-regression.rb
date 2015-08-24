require 'cocoapods-regression/builder'
require 'cocoapods-regression/version'
require 'cocoapods-regression/xcode'

require 'yaml'

module CocoaPods
  module Regression
    def self.clone(git_url, name)
      target_dir = "#{ENV['TMPDIR']}/#{name}"
      return target_dir if Dir.exist?(target_dir)

      puts "Cloning #{git_url}..."
      execute("git clone #{git_url} --depth=1 --recursive '#{target_dir}'")

      target_dir
    end

    def self.execute(command)
      puts(defined?(Bundler) ? Bundler.with_clean_env { `#{command}` } : `#{command}`)

      if $? != 0
        $stderr.puts "`#{command}` failed to execute."
        exit(2)
      end
    end

    def self.test!(app_name, development_cocoapods)
      app_config_path = File.expand_path("../../apps/#{app_name}.yaml", __FILE__)

      unless File.exist?(app_config_path)
        $stderr.puts "Regression test `#{app_name}` does not exist."
        exit(1)
      end

      app = YAML.load(File.new(app_config_path))
      checkout = CocoaPods::Regression.clone(app['source'], app_name)
      xcode = CocoaPods::Regression::Xcode.new(app)

      builder = CocoaPods::Regression::Builder.new(app)
      builder.working_directory = checkout

      # Build using current stable CP
      unless builder.build(xcode)
        $stderr.puts "Couldn't build using stable CP, aborting."
        exit(3)
      end

      # Build by using new CP only
      unless builder.build(xcode, development_cocoapods)
        $stderr.puts "Couldn't do a clean build using development CP, aborting."
        exit(3)
      end

      # Build by using stable CP, then new CP
      unless builder.build_upgrade(xcode, development_cocoapods)
        $stderr.puts "Couldn't do an upgrade build using development CP, aborting."
        exit(3)
      end

      puts 'The development CP is 👍'
    end

    def self.apps
      Dir.glob(File.expand_path('../../apps/*.yaml', __FILE__)).map { |app| File.basename(app, '.yaml') }
    end
  end
end
