require 'regression/cocoapods'
require 'regression/xcode'

module CocoaPods
  module Regression
    class Builder
      attr_accessor :working_directory

      def initialize(app)
        @steps = app['build']
      end

      def build(xcode, pod = 'pod', second_pod = nil)
        Regression.nuke_derived_data

        Dir.chdir(working_directory) do
          Regression.execute('git reset --hard')
          # Regression::execute('env')
          Regression.clean_pods
          Regression.install(pod)
          Regression.install(second_pod) unless second_pod.nil?

          execute_steps
        end
      end

      def execute_steps
        @steps.each do |step|
          puts step
          Regression.execute("#{xcode.use} #{step}")
        end
      end

      def build_upgrade(xcode, pod)
        build(xcode, 'pod', pod)
      end
    end
  end
end
