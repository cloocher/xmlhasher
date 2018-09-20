$:.push File.expand_path('../../lib', __FILE__)

require 'benchmark'
require 'xmlhasher'
begin
  require 'nori'
rescue LoadError
  puts "nori gem in not installed, run 'gem install nori'"
end
begin
  require 'active_support/core_ext/hash/conversions'
rescue LoadError
  puts "active_support gem in not installed, run 'gem install activesupport'"
end
begin
  require 'xmlsimple'
rescue LoadError
  puts "xmlsimple gem in not installed, run 'gem install xml-simple'"
end
begin
  require 'nokogiri'
rescue LoadError
  puts "nokogiri gem in not installed, run 'gem install nokogiri'"
end
begin
  require 'libxml'
rescue LoadError
  puts "libxml gem in not installed, run 'gem install libxml-ruby'"
end


def benchmark(runs, xml)
  label_width = 25 # needs to be >= any label's size

  Benchmark.bm(label_width) do |x|
    ActiveSupport::XmlMini.backend = ActiveSupport::XmlMini_REXML
    x.report 'activesupport(rexml)' do
      runs.times { Hash.from_xml(xml) }
    end

    ActiveSupport::XmlMini.backend = 'LibXML'
    x.report 'activesupport(libxml)' do
      runs.times { Hash.from_xml(xml) }
    end

    ActiveSupport::XmlMini.backend = 'Nokogiri'
    x.report 'activesupport(nokogiri)' do
      runs.times { Hash.from_xml(xml) }
    end

    x.report 'xmlsimple' do
      runs.times { XmlSimple.xml_in(xml) }
    end

    x.report 'nori' do
      runs.times { Nori.new(:advanced_typecasting => false).parse(xml) }
    end

    x.report 'xmlhasher' do
      runs.times { XmlHasher.parse(xml) }
    end
  end
end

puts 'Converting small xml from text to Hash:'
benchmark(100, File.read(File.expand_path('../../test/fixtures/institution.xml', __FILE__)))
puts 'Converting large xml from file to Hash:'
benchmark(5, File.read(File.expand_path('../../test/fixtures/institutions.xml', __FILE__)))
puts
