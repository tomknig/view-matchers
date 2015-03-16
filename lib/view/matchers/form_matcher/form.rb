module ViewMatchers
  module FormMatcher
    class Form
      def initialize(block)
        @block = block
        self
      end

      def matches?(actual_form)
        @actual_form = actual_form
        @matches = true
        instance_eval(&@block)
        @matches
      end

      def failure_message
        failure_messages 'did not exist'
      end

      def failure_message_when_negated
        failure_messages 'did exist'
      end

      private

      def method_missing(method, *args, &block)
        @matches &= matches_selector? method, *args, &block
      end

      def matches_selector?(selector, name, hash = nil, &block)
        matcher = ''
        matcher << matcher_for('name', name) if name
        hash.keys.each { |key| matcher << matcher_for(key, hash[key]) } if hash
        matches = @actual_form.xpath("//#{selector}#{matcher}").any?
        # the instance_evals block should now be namespaces within currently found selector
        instance_eval(&block) if matches && block_given?
        failures[name] = selector unless matches
        matches
      end

      def matcher_for(key, value)
        "[@#{key}=\"#{value}\"]"
      end

      def failures
        @failures ||= {}
      end

      def failure_messages(reason)
        messages = failures.keys.map do |key|
          "#{failures[key]} for #{key} #{reason}."
        end
        messages.join("\n")
      end

      undef_method :select
    end
  end
end
