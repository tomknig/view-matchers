module ViewMatchers
  class Form
    attr_reader :failures

    def initialize(block)
      @block = block
      self
    end

    def exists_in_rendered?(actual_form)
      @failures = {}
      @current_scope = actual_form
      @exists_in_rendered = true
      instance_eval(&@block)
      @exists_in_rendered
    end

    private

    def method_missing(method, *args, &block)
      @exists_in_rendered &= matches_selector? method, *args, &block
    end

    def matches_selector?(selector, name, hash = nil, &block)
      matches = @current_scope.xpath xpath(selector, name, hash)
      if matches.any?
        return matches_nested_selectors?(matches, &block) if block_given?
        return true
      else
        add_failure_message selector, name, hash
        return false
      end
    end

    def matches_nested_selectors?(matches, &block)
      previous_scope = @current_scope
      @current_scope = matches
      retval = instance_eval(&block)
      @current_scope = previous_scope
      retval
    end

    def xpath(selector, name, hash = nil)
      matcher = ''
      matcher << explicit_matcher('name', name) if name
      hash.keys.each { |key| matcher << fuzzy_matcher(key, hash[key]) } if hash
      ".//#{selector}#{matcher}"
    end

    def explicit_matcher(key, value)
      "[@#{key}=\"#{value}\"]"
    end

    def fuzzy_matcher(key, value)
      "[contains(@#{key}, \"#{value}\")]"
    end

    def add_failure_message(selector, name, hash)
      failures_for_selector(selector) << selector.to_s +
        failure_message('named', name).to_s +
        failure_message('attributes', hash).to_s
    end

    def failure_message(description, object)
      " #{description}: #{object} " if object
    end

    def failures_for_selector(selector)
      failures[selector] ||= []
    end

    undef_method :select
  end
end
