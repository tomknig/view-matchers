require 'nokogiri'

require 'view/matchers/table_matcher'
require 'view/matchers/form_matcher'

module ViewMatchers
  def match_form(block)
    FormMatcher.new(block)
  end

  def match_table(ascii_table)
    TableMatcher.new(ascii_table)
  end
end
