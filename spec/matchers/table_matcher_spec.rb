require 'spec_helper'

module ViewMatchers
  RSpec.describe ViewMatchers::TableMatcher, type: :view do
    let(:rendered) do
      %(
        <html>
          <body>
            <table>
              <tbody>
                <tr>
                  <td>irrelevant table</td>
                </tr>
              </tbody>
            </table>
            <table>
              <thead>
                <tr>
                  <th>Number</th>
                  <th>Product</th>
                  <th>Price</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>1</td>
                  <td>Computer</td>
                  <td>42,00 €</td>
                </tr>
                <tr>
                  <td>2</td>
                  <td>Phone</td>
                  <td>21,00 €</td>
                </tr>
              </tbody>
            </table>
          <body>
        <html>
      )
    end

    describe 'match_table' do
      it 'does not match a completely different table' do
        expect(rendered).not_to match_table %(
          +----------+----------+
          |        3 |        5 |
          +----------+----------+
          |        4 |        6 |
          +----------+----------+
        )
      end

      it 'does not match a missing cell' do
        expect(rendered).not_to match_table %(
          +----------+
          |        3 |
          +----------+
        )
      end

      it 'does not match slighly different tables' do
        expect(rendered).not_to match_table %(
          +----------+----------+----------+
          |        1 | Computer |  42,00 € |
          +----------+----------+----------+
          |        2 |    Phone |  22,00 € |
          +----------+----------+----------+
        )
      end

      it 'does not match slighly different tables' do
        expect(rendered).not_to match_table %(
          +----------+----------+----------+
          |        2 | Computer |  42,00 € |
          +----------+----------+----------+
          |        1 |    Phone |  21,00 € |
          +----------+----------+----------+
        )
      end

      it 'does not match table with missing inner column' do
        expect(rendered).not_to match_table %(
          +----------+----------+
          |        1 |  42,00 € |
          +----------+----------+
          |        2 |  21,00 € |
          +----------+----------+
        )
      end

      it 'does not match table with missing inner row' do
        expect(rendered).not_to match_table %(
          +----------+----------+----------+
          |   Number |  Product |    Price |
          +----------+----------+----------+
          |        2 |    Phone |  21,00 € |
          +----------+----------+----------+
        )
      end

      it 'does not match table with shifted rows' do
        expect(rendered).not_to match_table %(
          +----------+----------+
          | Computer |  42,00 € |
          +----------+----------+
          |        2 |    Phone |
          +----------+----------+
        )
      end

      it 'matches the exact same table' do
        expect(rendered).to match_table %(
          +----------+----------+----------+
          |   Number |  Product |    Price |
          +----------+----------+----------+
          |        1 | Computer |  42,00 € |
          +----------+----------+----------+
          |        2 |    Phone |  21,00 € |
          +----------+----------+----------+
        )
      end

      it 'matches vertically partially existing table' do
        expect(rendered).to match_table %(
          +----------+----------+----------+
          |        1 | Computer |  42,00 € |
          +----------+----------+----------+
          |        2 |    Phone |  21,00 € |
          +----------+----------+----------+
        )
      end

      it 'matches an existing cell' do
        expect(rendered).to match_table %(
          +----------+
          | Computer |
          +----------+
        )
      end

      it 'matches partially existing table' do
        expect(rendered).to match_table %(
          +----------+----------+
          |        1 | Computer |
          +----------+----------+
          |        2 |    Phone |
          +----------+----------+
        )
      end

      it 'matches horizontally, partially existing table' do
        expect(rendered).to match_table %(
          +----------+----------+
          | Computer |  42,00 € |
          +----------+----------+
          |    Phone |  21,00 € |
          +----------+----------+
        )
      end

      it 'matches vertically, partially existing table' do
        expect(rendered).to match_table %(
          +----------+----------+----------+
          |   Number |  Product |    Price |
          +----------+----------+----------+
          |        1 | Computer |  42,00 € |
          +----------+----------+----------+
        )
      end
    end
  end
end
