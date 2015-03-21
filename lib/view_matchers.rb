require 'nokogiri'

require 'view_matchers/table_matcher'
require 'view_matchers/form_matcher'
require 'view_matchers/version'

module ViewMatchers
  def match_form(block)
    FormMatcher.new(block)
  end

  def match_table(ascii_table)
    TableMatcher.new(ascii_table)
  end
end
