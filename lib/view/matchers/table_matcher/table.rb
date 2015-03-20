module ViewMatchers
  class Table
    def initialize(table)
      @table = table
      self
    end

    def contains?(table)
      possible_origins_of(table).each do |origin|
        return true if table_contained_continuously_from_index? table, origin
      end
      false
    end

    private

    def row_contained_in_row_at_index?(row, index)
      actual_row = rows[index]
      0.upto(actual_row.length - row.length) do |origin|
        return origin if row_contains_row_from_index? actual_row, row, origin
      end
      nil
    end

    def possible_origins_of(table)
      indices = rows.map.with_index do |_row, index|
        index if row_contained_in_row_at_index? table.rows.first, index
      end
      indices.reject(&:nil?)
    end

    def row_contains_row_from_index?(actual_row, expected_row, origin)
      offset = expected_row.length + origin - 1
      actual_row = actual_row[origin..offset].map(&:rstrip)
      expected_row.map!(&:rstrip)
      actual_row == expected_row
    end

    def table_contained_continuously_from_index?(table, origin)
      matches = table.rows.map.with_index do |row, offset|
        row_contained_in_row_at_index? row, (origin + offset)
      end
      matches.all? && matches.uniq.length == 1
    end
  end
end
