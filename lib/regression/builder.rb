require 'regression/cocoapods'
require 'regression/xcode'

module CocoaPods
  module Regression
    class Builder
      attr_accessor :working_directory

      def initialize(app)
        @steps = app['build']
      end

      def build(xcode)
        Regression.nuke_derived_data

        Dir.chdir(working_directory) do
          Regression.execute('git reset --hard')
          # Regression::execute('env')
          Regression.install

          @steps.each do |step|
            puts step
            Regression.execute("BUNDLE_GEMFILE='' #{xcode.use} #{step}")
          end
        end
      end
    end
  end
end
