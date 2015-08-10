module CocoaPods
  module Regression
    def self.install
      puts 'Installing pods...'
      execute('yes|BUNDLE_GEMFILE='' RUBYOPT='' pod install --no-repo-update')
    end
  end
end
