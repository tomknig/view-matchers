require 'view/matchers/table_matcher/ascii_table'
require 'view/matchers/table_matcher/html_table'

module ViewMatchers
  class TableMatcher
    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      expected_table = ASCIITable.new(@expected)

      Nokogiri::HTML(target).xpath('//table').each do |table|
        actual_table = HTMLTable.new(table)
        return true if actual_table.contains? expected_table
      end

      false
    end

    def failure_message
      'expected that the table contents would match'
    end

    def failure_message_when_negated
      'expected that the table contents would not match'
    end
  end
end
