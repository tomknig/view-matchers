require 'view/matchers/table_matcher/table'

module ViewMatchers
  class HTMLTable < Table
    def rows
      @rows ||= parse_rows
    end

    private

    def parse_rows
      @rows = @table.xpath('.//tr')
      parse_cols
    end

    def parse_cols
      @rows = @rows.collect do |row|
        row.xpath('.//th | .//td').collect(&:content)
      end
    end
  end
end
