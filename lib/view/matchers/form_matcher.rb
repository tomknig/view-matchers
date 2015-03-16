require 'view/matchers/form_matcher/form'

module ViewMatchers
  module FormMatcher
    RSpec::Matchers.define :match_form do |expected|
      match do |actual|
        @form = Form.new(expected)

        Nokogiri::HTML(actual).xpath('//form').each do |actual_form|
          return true if @form.matches? actual_form
        end

        false
      end

      failure_message do
        @form.failure_message
      end

      failure_message_when_negated do
        @form.failure_message_when_negated
      end

      description do
        'match forms'
      end

      diffable
    end
  end
end
