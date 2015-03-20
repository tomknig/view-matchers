require 'view/matchers/table_matcher/table'

module ViewMatchers
  class HTMLTable < Table
    def rows
      unless defined? @rows
        @rows = @table.xpath('//tr')
        @rows = @rows.collect do |row|
          cols(row)
        end
      end
      @rows
    end

    def cols(row)
      row.xpath('th | td').collect(&:content)
    end
  end
end
