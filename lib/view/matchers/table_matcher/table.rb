module ViewMatchers
  class Table
    def initialize(table)
      @table = table
      self
    end

    def contains?(table)
      possible_origins_of(table).each do |origin|
        matches = continuous_row_matches_from_index table, origin
        return true if matches.all? && matches.uniq.length == 1
      end
      false
    end

    private

    def possible_origins_of(table)
      indices = rows.map.with_index do |_row, index|
        index if row_contained_in_row? rows[index], table.rows.first
      end
      indices.reject(&:nil?)
    end

    def continuous_row_matches_from_index(table, origin)
      table.rows.map.with_index do |expected_row, offset|
        row_contained_in_row? rows[(origin + offset)], expected_row
      end
    end

    def row_contained_in_row?(row, expected_row)
      upper_bound = row.length - expected_row.length
      (0..upper_bound).each do |origin|
        return origin if row_matches_row_from_index? row, expected_row, origin
      end
      nil
    end

    def row_matches_row_from_index?(row, expected_row, origin)
      upper_bound = origin + expected_row.length - 1
      row = row[origin..upper_bound]
      row.map(&:rstrip) == expected_row.map(&:rstrip)
    end
  end
end
