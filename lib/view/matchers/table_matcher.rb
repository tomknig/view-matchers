require 'view/matchers/table_matcher/ascii_table'
require 'view/matchers/table_matcher/html_table'

module ViewMatchers
  module TableMatcher
    RSpec::Matchers.define :match_table do |expected|
      match do |actual|
        expected_table = ASCIITable.new(expected)

        Nokogiri::HTML(actual).xpath('//table').each do |table|
          actual_table = HTMLTable.new(table)
          return true if actual_table.contains? expected_table
        end

        false
      end

      failure_message do
        'expected that the table contents would match'
      end

      failure_message_when_negated do
        'expected that the table contents would not match'
      end

      description do
        'match table contents'
      end

      diffable
    end
  end
end
