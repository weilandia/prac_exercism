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

  def reverse!
    tmp_list = SimpleLinkedList.new
    while node = pop
      tmp_list.push(node)
    end

    self.head = tmp_list.first
    self
  end

  def to_a
    map(&:datum)
  end

  private

    def head=(node)
      @_head = node
    end

    def head
      @_head
    end

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
