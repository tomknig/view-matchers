require 'spec_helper'

module ViewMatchers
  RSpec.describe ViewMatchers::TableMatcher, type: :view do
    let(:rendered) do
      %(
        <html>
          <body>
            <form action="/clients" accept-charset="UTF-8" method="post">
              <input name="utf8" type="hidden" value="✓">
              <input name="authenticity_token" type="hidden" value="...">
              <input type="email" name="client[email]"></div>
              <input type="password" name="client[password]"></div>
              <input type="password" name="client[password_confirmation]"></div>
              <select name="client[supplier_id]">
                <option value="1" selected>Eine kleine Firma</option>
                <option value="2">Eine andere Firma</option>
              </select>
              <input type="submit" name="commit">
              <option value="outside select"></option>
            </form>
            <option value="outside form"></option>
          <body>
        <html>
      )
    end

    describe 'match_form' do
      it 'matches the exact same form' do
        expect(rendered).to match_form proc {
          input 'utf8', type: 'hidden', value: '✓'
          input 'authenticity_token', type: 'hidden', value: '...'
          input 'client[email]', type: 'email'
          input 'client[password]', type: 'password'
          input 'client[password_confirmation]', type: 'password'
          select 'client[supplier_id]' do
            option nil, value: '1'
            option nil, value: '2'
          end
        }
      end

      it 'matches selected options within a select' do
        expect(rendered).to match_form proc {
          select 'client[supplier_id]' do
            option nil, value: '2'
          end
        }
      end

      it 'does not match elements outside a form' do
        expect(rendered).not_to match_form proc {
          option nil, value: 'outside form'
        }
      end

      it 'does not match options outside the select' do
        expect(rendered).not_to match_form proc {
          select 'client[supplier_id]' do
            option nil, value: 'outside select'
          end
        }
      end
    end
  end
end
