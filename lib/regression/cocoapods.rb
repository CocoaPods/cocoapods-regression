module CocoaPods
  module Regression
    def self.clean_pods
      FileUtils.rm_rf('Pods')
    end

    def self.install(pod)
      puts 'Installing pods...'
      execute("yes|BUNDLE_GEMFILE='' RUBYOPT='' #{pod} install --no-repo-update")
    end
  end
end
