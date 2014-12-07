class Assert
  class NotEqual < StandardError; end

  def self.equal s1, s2, msg="#{s1} != #{s2}"
    raise Assert::NotEqual.new(msg) if s1 != s2
  end
end
