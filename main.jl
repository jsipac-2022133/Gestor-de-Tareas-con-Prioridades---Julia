include("structures.jl")

queue = PendingQueue(nothing, nothing, 0)
tree = PriorityTree(nothing, 0)
completed = CompletedList(nothing, nothing, 0)

t1 = create_task(1, "Comprar insumos", 2)
t2 = create_task(2, "Llamar al cliente", 1)
t3 = create_task(3, "Enviar reporte", 3)

enqueue(queue, t1)
enqueue(queue, t2)
enqueue(queue, t3)

println("Tareas en cola: ", queue.size)
println("Siguiente tarea: ", peek_queue(queue).title)

primera = dequeue(queue)
println("Desencolada: ", primera.title)
println("Tareas en cola: ", queue.size)