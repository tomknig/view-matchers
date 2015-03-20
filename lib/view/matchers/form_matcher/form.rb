module ViewMatchers
  class Form
    attr_reader :failures

    def initialize(block)
      @block = block
      self
    end

    def matches?(actual_form)
      @failures = {}
      @scope = actual_form
      @matches = true
      instance_eval(&@block)
      @matches
    end

    private

    def method_missing(method, *args, &block)
      @matches &= matches_selector? method, *args, &block
    end

    def matches_selector?(selector, name, hash = nil, &block)
      matches = @scope.xpath xpath_for(selector, name, hash)
      if matches.any?
        return matches_nested_selectors?(matches, &block) if block_given?
        return true
      else
        add_failure selector, name, hash
        return false
      end
    end

    def matches_nested_selectors?(matches, &block)
      scope = @scope
      @scope = matches
      retval = instance_eval(&block)
      @scope = scope
      retval
    end

    def xpath_for(selector, name, hash = nil)
      matcher = ''
      matcher << explicit_matcher_for('name', name) if name
      hash.keys.each { |key| matcher << fuzzy_matcher_for(key, hash[key]) } if hash
      ".//#{selector}#{matcher}"
    end

    def explicit_matcher_for(key, value)
      "[@#{key}=\"#{value}\"]"
    end

    def fuzzy_matcher_for(key, value)
      "[contains(@#{key}, \"#{value}\")]"
    end

    def add_failure(selector, name, hash)
      failure = ''
      failure << "named: #{name} " if name
      failure << "with attributes: #{hash}" if hash
      (failures[selector] ||= []) << failure
    end

    undef_method :select
  end
end
