module ViewMatchers
  class Form
    def initialize(block)
      @block = block
      self
    end

    def matches?(actual_form)
      @scope = actual_form
      @matches = true
      instance_eval(&@block)
      @matches
    end

    def failure_messages(reason)
      messages = failures.keys.map do |key|
        "#{failures[key]} for #{key} #{reason}."
      end
      messages.join("\n")
    end

    private

    def method_missing(method, *args, &block)
      @matches &= matches_selector? method, *args, &block
    end

    def matches_selector?(selector, name, hash = nil, &block)
      matches = @scope.xpath xpath_for(selector, name, hash)
      if matches.any?
        if block_given?
          scope = @scope
          @scope = matches
          retval = instance_eval(&block)
          @scope = scope
          return retval
        end
        return true
      else
        failures[name] = selector
        return false
      end
    end

    def xpath_for(selector, name, hash = nil)
      matcher = ''
      matcher << matcher_for('name', name) if name
      hash.keys.each { |key| matcher << matcher_for(key, hash[key]) } if hash
      ".//#{selector}#{matcher}"
    end

    def matcher_for(key, value)
      "[@#{key}=\"#{value}\"]"
    end

    def failures
      @failures ||= {}
    end

    undef_method :select
  end
end
