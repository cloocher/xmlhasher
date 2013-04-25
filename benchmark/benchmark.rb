$:.push File.expand_path('../../lib', __FILE__)

require 'benchmark'
require 'xmlhasher'
begin
  require 'nori'
rescue
  puts "nori gem in not install, run 'gem install nori'"
end
begin
  require 'active_support/core_ext/hash/conversions'
rescue
  puts "active_support gem in not install, run 'gem install activesupport'"
end
begin
  require 'xmlsimple'
rescue
  puts "xmlsimple gem in not install, run 'gem install xml-simple'"
end
begin
  require 'nokogiri'
rescue
  puts "nokogiri gem in not install, run 'gem install nokogiri'"
end
begin
  require 'libxml'
rescue
  puts "libxml gem in not install, run 'gem install libxml-ruby'"
end


runs = 100
xml = File.read(File.expand_path('../../test/fixtures/institution.xml', __FILE__))
puts 'Benchmarking conversion of small xml from text to Hash'
Benchmark.bm 10 do |x|
  ActiveSupport::XmlMini.backend = ActiveSupport::XmlMini_REXML
  x.report 'activesupport(rexml)   ' do
    runs.times { Hash.from_xml(xml) }
  end

  ActiveSupport::XmlMini.backend = 'LibXML'
  x.report 'activesupport(libxml)  ' do
    runs.times { Hash.from_xml(xml) }
  end

  ActiveSupport::XmlMini.backend = 'Nokogiri'
  x.report 'activesupport(nokogiri)' do
    runs.times { Hash.from_xml(xml) }
  end

  x.report 'xmlsimple              ' do
    runs.times { XmlSimple.xml_in(xml) }
  end

  x.report 'nero                   ' do
    runs.times { Nori.new(:advanced_typecasting => false).parse(xml) }
  end

  x.report 'xmlhasher              ' do
    runs.times { XmlHasher.parse(xml) }
  end
end

runs = 5
puts
path = File.expand_path('../../test/fixtures/institutions.xml', __FILE__)
puts 'Benchmarking conversion of large xml from file to Hash'
Benchmark.bm 5 do |x|
  ActiveSupport::XmlMini.backend = ActiveSupport::XmlMini_REXML
  x.report 'activesupport(rexml)   ' do
    runs.times { Hash.from_xml(File.new(path)) }
  end

  ActiveSupport::XmlMini.backend = 'LibXML'
  x.report 'activesupport(libxml)  ' do
    #runs.times { Hash.from_xml(File.new(path)) } # Segmentation fault
  end

  ActiveSupport::XmlMini.backend = 'Nokogiri'
  x.report 'activesupport(nokogiri)' do
    runs.times { Hash.from_xml(File.new(path)) }
  end

  x.report 'xmlsimple              ' do
    runs.times { XmlSimple.xml_in(path) }
  end

  x.report 'nero                   ' do
    runs.times { Nori.new(:advanced_typecasting => false).parse(File.new(path).read) } # Nori doesn't support reading from a stream, load the file in memory
  end

  x.report 'xmlhasher              ' do
    runs.times { XmlHasher.parse(File.new(path)) }
  end
end
