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

function search_in_tree(node::Union{TaskNode, Nothing}, priority::Int, results::Vector{TaskNode})
    if node === nothing
        return
    end
    if node.priority == priority
        push!(results, node)
    end
    search_in_tree(node.left, priority, results)
    search_in_tree(node.right, priority, results)
end

function find_by_priority(manager::TaskManager, priority::Int)
    results = TaskNode[]
    search_in_tree(manager.tree.root, priority, results)
    return results
end

function find_completed_by_id(manager::TaskManager, id::Int)
    current = manager.completed.head
    while current !== nothing
        if current.task.id == id
            return current.task
        end
        current = current.next
    end
    return nothing
end

function full_report(manager::TaskManager)
    println("========== REPORTE ==========")
    println("Total registradas: ", manager.next_id - 1)
    println("Pendientes en cola: ", manager.queue.size)
    println("En arbol activo:    ", manager.tree.size)
    println("Completadas:        ", manager.completed.size)
    println()
    println("Pendientes por prioridad:")
    sorted = get_sorted_tasks(manager.tree)
    for t in sorted
        println("  [prioridad=", t.priority, "] ", t.title)
    end
    println()
    println("Historial completadas:")
    print_completed(manager.completed)
    println("=============================")
end
