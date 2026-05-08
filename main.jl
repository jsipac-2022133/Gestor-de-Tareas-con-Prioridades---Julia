include("structures.jl")

queue = PendingQueue(nothing, nothing, 0)
tree = PriorityTree(nothing, 0)
completed = CompletedList(nothing, nothing, 0)

t1 = create_task(1, "Comprar insumos", 2)
t2 = create_task(2, "Llamar al cliente", 1)
t3 = create_task(3, "Enviar reporte", 3)
t4 = create_task(4, "Actualizar sistema", 5)
t5 = create_task(5, "Revisar correos", 1)

enqueue(queue, t1)
enqueue(queue, t2)
enqueue(queue, t3)

insert_tree(tree, t1)
insert_tree(tree, t2)
insert_tree(tree, t3)
insert_tree(tree, t4)
insert_tree(tree, t5)

println("Tareas en arbol: ", tree.size)
println("Tarea de mayor prioridad: ", find_max_priority(tree.root).title)

sorted = get_sorted_tasks(tree)
println("Tareas ordenadas por prioridad:")
for t in sorted
    println("  [", t.priority, "] ", t.title)
end