require 'view/matchers/form_matcher/form'

module ViewMatchers
  class FormMatcher
    def initialize(expected)
      @expected = expected
    end

    def matches?(rendered)
      @form = Form.new(@expected)
      expectation_exists_in_rendered? rendered
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

    def expectation_exists_in_rendered?(rendered)
      Nokogiri::HTML(rendered).xpath('//form').each do |rendered_form|
        return true if @form.exists_in_rendered? rendered_form
        update_failure_messages
      end

      false
    end

    def update_failure_messages
      current_failures = @form.failures
      @failures = current_failures if current_failures.size < failures.size
    end

    def failure_messages
      messages = @failures.keys.map do |selector|
        @failures[selector].join("\n")
      end
      messages.join
    end

    def failures
      @failures ||= @form.failures
    end
  end
end
