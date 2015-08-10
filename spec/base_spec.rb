require File.expand_path('../spec_helper', __FILE__)

module CocoaPods
  describe Regression do
    it 'can execute a shell command' do
      -> { Regression.execute('false') }.should.raise SystemExit
    end
  end
end
