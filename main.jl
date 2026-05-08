include("structures.jl")

queue = PendingQueue(nothing, nothing, 0)
tree = PriorityTree(nothing, 0)
completed = CompletedList(nothing, nothing, 0)

t1 = create_task(1, "Comprar insumos", 2)
t2 = create_task(2, "Llamar al cliente", 1)
t3 = create_task(3, "Enviar reporte", 3)
t4 = create_task(4, "Actualizar sistema", 5)
t5 = create_task(5, "Revisar correos", 1)

for t in [t1, t2, t3, t4, t5]
    enqueue(queue, t)
    insert_tree(tree, t)
end

primera = dequeue(queue)
complete_task(completed, primera)

segunda = dequeue(queue)
complete_task(completed, segunda)

println("Tareas completadas: ", completed.size)
print_completed(completed)

println("Tareas pendientes en cola: ", queue.size)

remove_completed(completed, 1)
println("Tras eliminar id=1, completadas: ", completed.size)