# CocoaPods::Regression

Automation harness for CocoaPods regression tests.

## Usage

List available regression tests:

```bash
$ bin/cp-regression 
Available regression tests:
	eigen
	WordPress-iOS
```

Execute a specific regression test:

```bash
$ bin/cp-regression eigen
[...]
▸ Processing Artsy-Info.plist
▸ Generating 'Artsy.app.dSYM'
▸ Running script 'Embed Pods Frameworks'
▸ Running script 'Copy Pods Resources'
▸ Touching Artsy.app
```

## Installation

Install it yourself as:

    $ gem install cocoapods-regression

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/neonichu/cocoapods-regression.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

