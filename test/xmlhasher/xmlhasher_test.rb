require 'test_helper'

class XmlhasherTest < Test::Unit::TestCase

  def test_configure
    configurable = XmlHasher.configure do |config|
      config.snakecase = true
      config.ignore_namespaces = true
    end
    assert_equal true, configurable.instance_variable_get(:'@snakecase')
    assert_equal true, configurable.instance_variable_get(:'@ignore_namespaces')
  end
end
