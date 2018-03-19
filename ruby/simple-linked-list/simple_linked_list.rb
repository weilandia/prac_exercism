module BookKeeping
  VERSION = 1
end

class SimpleLinkedList
  include Enumerable

  def initialize(data = [])
    build_list(data)
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
    map(&:datum)
  end

  def reverse!
    self.head = reverse.first
    self
  end

  def reverse
    tmp_list = SimpleLinkedList.new
    while node = pop
      tmp_list.push(node)
    end

    tmp_list
  end

  private
    attr_accessor :head

    def build_list(data)
      data.each do |datum|
        push(Element.new(datum))
      end
    end

    def each
      node = head

      while node
        yield node
        node = node.next
      end
    end
end

class Element
  attr_accessor :next
  attr_reader   :datum

  def initialize(datum, next_datum = nil)
    @datum = datum
    @next  = next_datum
  end
end
