# XmlHasher

[![Build Status](https://travis-ci.org/cloocher/xmlhasher.png)](https://travis-ci.org/cloocher/xmlhasher)
[![Gem Version](https://badge.fury.io/rb/xmlhasher.png)](http://badge.fury.io/rb/xmlhasher)

Fast XML to Ruby Hash converter

## Installation

## Installation

Aggcat is available through [Rubygems](http://rubygems.org/gems/xmlhasher) and can be installed via:

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
XmlHasher.configure do |config|
  config.snakecase = true
  config.ignore_namespaces = true
end

# alternatively, specify configuration options when instantiating a Parser
parser = XmlHasher::Parser.new(
  :snakecase => true,
  :ignore_namespaces => true
)

# parse XML file
XmlHasher.parse(File.new('/path/to/my/file.xml'))

# parse XML string
XmlHasher.parse("<tag1><tag2>content</tag2></tag1>")
# => {:tag1=>{:tag2=>"content"}}

```
## Benchmarks

How fast is it?  Try it for your self - [benchmark.rb](https://github.com/cloocher/xmlhasher/blob/master/benchmark/benchmark.rb)

```
Benchmarking conversion of small xml from text to Hash
                 user     system      total        real
activesupport(rexml)     0.380000   0.000000   0.380000 (  0.385326)
activesupport(libxml)    0.060000   0.000000   0.060000 (  0.062008)
activesupport(nokogiri)  0.090000   0.000000   0.090000 (  0.089466)
xmlsimple                0.480000   0.010000   0.490000 (  0.490938)
nero                     0.120000   0.000000   0.120000 (  0.123612)
xmlhasher                0.010000   0.000000   0.010000 (  0.017366)

Benchmarking conversion of large xml from file to Hash
            user     system      total        real
activesupport(rexml)    57.230000   0.240000  57.470000 ( 57.460510)
activesupport(libxml)   # Segmentation fault
activesupport(nokogiri) 12.650000   0.250000  12.900000 ( 12.908073)
xmlsimple               49.980000   0.160000  50.140000 ( 50.140775)
nero                    15.590000   0.110000  15.700000 ( 15.697411)
xmlhasher                4.290000   0.030000   4.320000 (  4.316379)
```
## Requirements

* Ruby 1.8.7 or higher

## Copyright
Copyright (c) 2013 Gene Drabkin.
See [LICENSE][] for details.

[license]: LICENSE.md
