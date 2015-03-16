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
                <option value=""></option>
                <option value="1">Eine kleine Firma</option>
              </select>
              <input type="submit" name="commit">
            </form>
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
          end
        }
      end
    end
  end
end
