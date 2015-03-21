require 'view_matchers/table_matcher/ascii_table'
require 'view_matchers/table_matcher/html_table'

module ViewMatchers
  class TableMatcher
    def initialize(expected)
      @expected = ASCIITable.new(expected)
    end

    def matches?(rendered)
      expectation_exists_in_rendered?(rendered)
    end

    def failure_message
      'expected that the table contents would match'
    end

    def failure_message_when_negated
      'expected that the table contents would not match'
    end

    private

    def expectation_exists_in_rendered?(rendered)
      Nokogiri::HTML(rendered).xpath('//table').each do |rendered_table|
        actual_table = HTMLTable.new(rendered_table)
        return true if actual_table.contains? @expected
      end

      false
    end
  end
end
