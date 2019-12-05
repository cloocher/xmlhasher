# XmlHasher

[![Build Status](https://travis-ci.org/cloocher/xmlhasher.png)](https://travis-ci.org/cloocher/xmlhasher)
[![Gem Version](https://badge.fury.io/rb/xmlhasher.png)](http://badge.fury.io/rb/xmlhasher)

Fast XML to Ruby Hash converter

## Installation

XmlHasher is available through [Rubygems](http://rubygems.org/gems/xmlhasher) and can be installed via:

```
$ gem install xmlhasher
```

or add it to your Gemfile like this:

```
gem 'xmlhasher'
```

## Release Notes

See [CHANGELOG.md](CHANGELOG.md)

## Usage

```ruby
require 'xmlhasher'

# XmlHasher global configuration
#
# snakecase - convert all keys to snake case notation
# ignore_namespaces - remove XML namespaces
# string_keys - represent keys as Strings instead of Symbols
#
# here is default configuration
XmlHasher.configure do |config|
  config.snakecase = true
  config.ignore_namespaces = true
  config.string_keys = false
end

# alternatively, specify configuration options when instantiating a Parser
parser = XmlHasher::Parser.new(
  :snakecase => true,
  :ignore_namespaces => true,
  :string_keys => false
)

# by default, XmlHasher will convert all keys to symbols.  If you want all keys to be Strings, set :string_keys option to 'true'

# parse XML file
XmlHasher.parse(File.new('/path/to/my/file.xml'))

# parse XML string
XmlHasher.parse("<tag1><tag2>content</tag2></tag1>")
# => {:tag1=>{:tag2=>"content"}}

```
## Benchmarks

How fast is it?  Try it for yourself `rake benchmark`

```sh
Converting small xml from text to Hash:
                 user     system      total        real
activesupport(rexml)     0.196861   0.000692   0.197553 (  0.197756)
activesupport(libxml)    0.028840   0.000176   0.029016 (  0.029037)
activesupport(nokogiri)  0.044063   0.000516   0.044579 (  0.044618)
xmlsimple                0.225291   0.014291   0.239582 (  0.239756)
nori                     0.048385   0.000379   0.048764 (  0.048806)
xmlhasher                0.011791   0.000098   0.011889 (  0.011895)

Converting large xml from file to Hash:
                 user     system      total        real
activesupport(rexml)    25.891326   0.144542  26.035868 ( 26.052577)
activesupport(libxml)    3.911317   0.072332   3.983649 (  3.985904)
activesupport(nokogiri)  6.126251   0.061193   6.187444 (  6.191296)
xmlsimple               26.128386   0.120480  26.248866 ( 26.265013)
nori                     6.347459   0.028522   6.375981 (  6.380416)
xmlhasher                1.738668   0.027549   1.766217 (  1.767256)

```
Note: benchmarks were generated on a 2015 Macbook Pro using Ruby 2.5.1

## Requirements

* Ruby 2.0.0 or higher

## Copyright
Copyright (c) 2013 Gene Drabkin.
See [LICENSE][] for details.

[license]: LICENSE.md
