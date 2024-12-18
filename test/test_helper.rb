require "simplecov"
require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(color: true)]

require_relative "../lib/rubyray"

def test(name, &block)
  test_name = :"test_#{name.gsub(/\s+/, "_")}"
  defined = method_defined? test_name
  raise "#{test_name} is already defined in #{self}" if defined

  if block_given?
    define_method(test_name, &block)
  else
    define_method(test_name) do
      flunk "No implementation provided for #{name}"
    end
  end
end

SimpleCov.start if ENV["COVERAGE"]
