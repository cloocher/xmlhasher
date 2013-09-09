require 'test_helper'

class XmlhasherTest < Test::Unit::TestCase

  def test_configure_settings_all_on
    configurable = XmlHasher.configure do |config|
      config.snakecase = true
      config.ignore_namespaces = true
      config.string_keys = true
    end
    assert_equal true, configurable.instance_variable_get(:'@snakecase')
    assert_equal true, configurable.instance_variable_get(:'@ignore_namespaces')
    assert_equal true, configurable.instance_variable_get(:'@string_keys')
  end

  def test_configure_settings_all_off
    configurable = XmlHasher.configure do |config|
      config.snakecase = false
      config.ignore_namespaces = false
      config.string_keys = false
    end
    assert_equal false, configurable.instance_variable_get(:'@snakecase')
    assert_equal false, configurable.instance_variable_get(:'@ignore_namespaces')
    assert_equal false, configurable.instance_variable_get(:'@string_keys')
  end

  def test_parser
    parser = XmlHasher.parser
    assert_equal XmlHasher::Parser, parser.class
    result = parser.parse(fixture('institution.xml').read)
    assert_not_empty result
    assert_equal Hash, result.class
  end

  def test_parse
    result = XmlHasher.parse(fixture('institution.xml').read)
    assert_not_empty result
    assert_equal Hash, result.class
  end

end
