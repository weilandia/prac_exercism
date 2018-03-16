module BookKeeping
  VERSION = 1
end

class SimpleLinkedList
  attr_accessor :head

  def initialize(data = nil)
    build_list(data) if data
  end

  def build_list(data)
    data.each do |datum|
      push(Element.new(datum))
    end
  end

  def push(element)
    element.next = head
    self.head = element
    self
  end

  def pop
    node = head
    self.head = node&.next
    node
  end

  def to_a
    node = head
    [].tap do |arr|
      while node
        arr << node.datum
        node = node.next
      end
    end
  end

  def reverse!
    tmp_list = SimpleLinkedList.new
    while node = pop
      tmp_list.push(node)
    end

    self.head = tmp_list.head
    self
  end
end

class Element
  attr_reader :datum

  def initialize(datum, next_datum = nil)
    @datum = datum
    self.next = next_datum
  end

  def next=(next_datum)
    @_next = next_datum
  end

  def next
    @_next
  end
end
