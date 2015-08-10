require 'xcode/install'

module CocoaPods
  module Regression
    def self.nuke_derived_data
      `rm -rf ~/Library/Developer/Xcode/DerivedData/*`
    end

    class Xcode
      def initialize(app)
        xcode_version = app['xcode']
        return if xcode_version.nil?

        installer = XcodeInstall::Installer.new
        xcode = installer.installed_versions.find { |x| x.version.start_with?(xcode_version.to_s) }

        if xcode.nil?
          $stderr.puts "Required Xcode version #{xcode_version} is not installed."
          exit(1)
        end

        @xcode = xcode
      end

      def use
        @xcode.nil? ? '' : "DEVELOPER_DIR=#{@xcode.path}"
      end
    end
  end
end
