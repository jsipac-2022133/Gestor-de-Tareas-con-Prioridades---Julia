mutable struct TaskNode
    id::Int
    title::String
    priority::Int
    created_at::Float64
    left::Union{TaskNode, Nothing}
    right::Union{TaskNode, Nothing}
end

mutable struct QueueNode
    task::TaskNode
    next::Union{QueueNode, Nothing}
end

mutable struct ListNode
    task::TaskNode
    prev::Union{ListNode, Nothing}
    next::Union{ListNode, Nothing}
end

mutable struct PendingQueue
    head::Union{QueueNode, Nothing}
    tail::Union{QueueNode, Nothing}
    size::Int
end

mutable struct PriorityTree
    root::Union{TaskNode, Nothing}
    size::Int
end

mutable struct CompletedList
    head::Union{ListNode, Nothing}
    tail::Union{ListNode, Nothing}
    size::Int
end

function create_task(id::Int, title::String, priority::Int)
    return TaskNode(id, title, priority, time(), nothing, nothing)
end

function enqueue(q::PendingQueue, task::TaskNode)
    node = QueueNode(task, nothing)
    if q.tail === nothing
        q.head = node
        q.tail = node
    else
        q.tail.next = node
        q.tail = node
    end
    q.size += 1
end

function dequeue(q::PendingQueue)
    if q.head === nothing
        return nothing
    end
    task = q.head.task
    q.head = q.head.next
    if q.head === nothing
        q.tail = nothing
    end
    q.size -= 1
    return task
end

function peek_queue(q::PendingQueue)
    if q.head === nothing
        return nothing
    end
    return q.head.task
end

function insert_tree(tree::PriorityTree, task::TaskNode)
    task.left = nothing
    task.right = nothing
    if tree.root === nothing
        tree.root = task
    else
        insert_node(tree.root, task)
    end
    tree.size += 1
end

function insert_node(node::TaskNode, task::TaskNode)
    if task.priority <= node.priority
        if node.left === nothing
            node.left = task
        else
            insert_node(node.left, task)
        end
    else
        if node.right === nothing
            node.right = task
        else
            insert_node(node.right, task)
        end
    end
end

function inorder(node::Union{TaskNode, Nothing}, result::Vector{TaskNode})
    if node === nothing
        return
    end
    inorder(node.left, result)
    push!(result, node)
    inorder(node.right, result)
end

function get_sorted_tasks(tree::PriorityTree)
    result = TaskNode[]
    inorder(tree.root, result)
    return result
end

function find_max_priority(node::Union{TaskNode, Nothing})
    if node === nothing
        return nothing
    end
    if node.right === nothing
        return node
    end
    return find_max_priority(node.right)
end

function complete_task(list::CompletedList, task::TaskNode)
    node = ListNode(task, nothing, nothing)
    if list.tail === nothing
        list.head = node
        list.tail = node
    else
        node.prev = list.tail
        list.tail.next = node
        list.tail = node
    end
    list.size += 1
end

function remove_completed(list::CompletedList, id::Int)
    current = list.head
    while current !== nothing
        if current.task.id == id
            if current.prev !== nothing
                current.prev.next = current.next
            else
                list.head = current.next
            end
            if current.next !== nothing
                current.next.prev = current.prev
            else
                list.tail = current.prev
            end
            list.size -= 1
            return current.task
        end
        current = current.next
    end
    return nothing
end

function print_completed(list::CompletedList)
    current = list.head
    while current !== nothing
        println("  [id=", current.task.id, "] ", current.task.title)
        current = current.next
    end
end