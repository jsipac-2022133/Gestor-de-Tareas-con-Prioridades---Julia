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