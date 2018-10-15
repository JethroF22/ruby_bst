class Queue
    def initialize
        @data = []
    end

    def enqueue value
        @data << value
    end

    def dequeue
        @data.shift
    end

    def empty?
      @data == []
    end

    def to_s
        display = []
        @data.each do |value|
            display << value
        end
        display
    end
end

class Node
    attr_accessor :value, :parent, :left, :right

    def initialize(value=nil, parent=nil, left=nil, right=nil)
        @value = value
        @parent = parent
        @left = left
        @right = right
    end

    def to_s
        @value.to_s
    end
end

class BinaryTree
    attr_accessor :root

    def initialize array
        build_tree(array)
    end

    def build_tree array
        queue = Queue.new
        root_node = Node.new(array[0])
        @root = root_node
        current_node = @root
        array_index = 1
        while true
            if array_index == array.length
                return
            else
                value = array[array_index]
                if ((current_node.left && current_node.right) ||
                    (current_node.left && (value < current_node.value)) ||
                    (current_node.right && (value > current_node.value)))
                    current_node = queue.dequeue
                else
                    if value > current_node.value
                        node = Node.new(value, current_node)
                        # node.value = value
                        # node.parent = current_node
                        current_node.right = node
                        queue.enqueue(current_node.right)
                    else
                        node = Node.new(value, current_node)
                        # node.value = value
                        # node.parent = current_node
                        current_node.left = node
                        queue.enqueue(current_node.left)
                    end
                    array_index += 1
                    if queue.empty?
                        break
                    end
                end
            end
        end
    end

    def breadth_first_search value
        queue = Queue.new
        queue.enqueue(@root)
        while !queue.empty?
            current_node = queue.dequeue
            if current_node.value == value
                puts "Node found"
                return current_node
            else
                if current_node.left
                    queue.enqueue(current_node.left)
                end
                if current_node.right
                    queue.enqueue(current_node.right)
                end
            end
        end
        return nil
    end

    def depth_first_search value
        stack = []
        stack << @root
        while stack.length > 0
            current_node = stack.pop
            puts "Current node: " + current_node.to_s
            if current_node.value == value
                puts "Node found"
                return current_node
            else
                if current_node.right
                    stack << current_node.right
                end
                if current_node.left
                    stack << current_node.left
                end
            end
        end
        return nil
    end

    def dfs_rec value, node
        if node == nil
            return nil
        else
            if node.value == value
                return node
            else
                node1 = dfs_rec(value, node.left)
                node2 = dfs_rec(value, node.right)
                if node1
                    return node1
                elsif node2
                    return node2
                end
            end
        end
    end
end

def generate_array
    result = []
    10.times do
        result << rand(1..20)
    end
    result
end

array = generate_array
p array
tree = BinaryTree.new(array)
puts tree.breadth_first_search(array[3]);
puts tree.depth_first_search(array[5]);
