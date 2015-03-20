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
        @failures = @form.failures if @form.failures.size < failures.size
      end

      false
    end

    def failure_message
      "the following expected tags did not exist:\n" <<
        failure_messages
    end

    def failure_message_when_negated
      "the following not expected tags actually did exist:\n" <<
        failure_messages
    end

    private

    INSET = '  '

    def failure_messages
      messages = @failures.keys.map do |selector|
        @failures[selector].map do |message|
          "#{INSET}#{selector} #{message}"
        end
      end
      messages.flatten.join("\n")
    end

    def failures
      @failures ||= @form.failures
    end
  end
end
