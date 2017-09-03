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
  :ignore_namespaces => true
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
activesupport(rexml)        0.210000   0.010000   0.220000 (  0.213469)
activesupport(libxml)       0.030000   0.000000   0.030000 (  0.037686)
activesupport(nokogiri)     0.060000   0.000000   0.060000 (  0.054711)
xmlsimple                   0.250000   0.020000   0.270000 (  0.268634)
nori                        0.060000   0.000000   0.060000 (  0.062009)
xmlhasher                   0.010000   0.000000   0.010000 (  0.013124)

Converting large xml from file to Hash:
                                user     system      total        real
activesupport(rexml)       31.980000   0.390000  32.370000 ( 32.486670)
activesupport(libxml)       5.050000   0.080000   5.130000 (  5.163404)
activesupport(nokogiri)     7.080000   0.090000   7.170000 (  7.218073)
xmlsimple                  32.040000   0.290000  32.330000 ( 32.490272)
nori                        8.480000   0.150000   8.630000 (  8.698013)
xmlhasher                   2.580000   0.050000   2.630000 (  2.640795)
```
Note: benchmarks were generated on a 2016 MacBook Pro using Ruby 2.4.1

## Requirements

* Ruby 1.9.3 or higher

## Copyright
Copyright (c) 2013 Gene Drabkin.
See [LICENSE][] for details.

[license]: LICENSE.md
