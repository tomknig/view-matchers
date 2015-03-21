require 'view/matchers/table_matcher/table'

module ViewMatchers
  class ASCIITable < Table
    def rows
      @rows ||= parse_rows
    end

    private

    def parse_rows
      @rows = @table.lines.map(&:strip)
      @rows.select! { |row| row.start_with?('|') }
      parse_cols
    end

    def parse_cols
      @rows.map! do |row|
        row.split('|').map(&:strip).reject(&:empty?)
      end
    end
  end
end
