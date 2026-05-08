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