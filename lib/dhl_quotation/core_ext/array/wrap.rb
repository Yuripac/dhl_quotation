class Array
  # Wraps its argument in an array unless it is already an array (or array-like).
  #
  # Specifically:
  #
  # * If the argument is +nil+ an empty array is returned.
  # * Otherwise, if the argument responds to +to_ary+ it is invoked, and its result returned.
  # * Otherwise, returns an array with the argument as its single element.
  #
  #     Array.wrap(nil)       # => []
  #     Array.wrap([1, 2, 3]) # => [1, 2, 3]
  #     Array.wrap(0)         # => [0]
  #     Array.wrap(foo: :bar) # => [{:foo=>:bar}]
  def self.wrap(object)
    if object.nil?
      []
    elsif object.respond_to?(:to_ary)
      object.to_ary || [object]
    else
      [object]
    end
  end
end
