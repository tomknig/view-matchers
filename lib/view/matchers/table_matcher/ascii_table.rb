require 'view/matchers/table_matcher/table'

module ViewMatchers
  module TableMatcher
    class ASCIITable < Table
      def rows
        unless defined? @rows
          @rows = @table.split("\n")
          @rows.map!(&:strip)
          @rows.select! { |row| row.start_with?('|') }
          @rows.map! { |row| cols(row) }
        end
        @rows
      end

      def cols(row)
        cols = row.split('|')
        cols.map!(&:strip)
        cols.reject(&:empty?)
      end
    end
  end
end
