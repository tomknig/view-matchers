require 'view/matchers/form_matcher/form'

module ViewMatchers
  class FormMatcher
    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      @form = Form.new(@expected)

      Nokogiri::HTML(target).xpath('//form').each do |actual_form|
        return true if @form.matches? actual_form
      end

      false
    end

    def failure_message
      @form.failure_messages 'did not exist'
    end

    def failure_message_when_negated
      @form.failure_messages 'did exist'
    end
  end
end
