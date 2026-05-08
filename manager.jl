include("structures.jl")

mutable struct TaskManager
    queue::PendingQueue
    tree::PriorityTree
    completed::CompletedList
    next_id::Int
end

function create_manager()
    return TaskManager(
        PendingQueue(nothing, nothing, 0),
        PriorityTree(nothing, 0),
        CompletedList(nothing, nothing, 0),
        1
    )
end

function add_task(manager::TaskManager, title::String, priority::Int)
    task = create_task(manager.next_id, title, priority)
    manager.next_id += 1
    enqueue(manager.queue, task)
    insert_tree(manager.tree, task)
    return task
end

function process_next(manager::TaskManager)
    task = dequeue(manager.queue)
    if task === nothing
        return nothing
    end
    complete_task(manager.completed, task)
    return task
end

function show_status(manager::TaskManager)
    println("--- Estado del gestor ---")
    println("Pendientes en cola: ", manager.queue.size)
    println("Tareas en arbol:    ", manager.tree.size)
    println("Completadas:        ", manager.completed.size)
end

function show_by_priority(manager::TaskManager)
    println("--- Tareas por prioridad ---")
    sorted = get_sorted_tasks(manager.tree)
    for t in sorted
        println("  [", t.priority, "] ", t.title)
    end
end
