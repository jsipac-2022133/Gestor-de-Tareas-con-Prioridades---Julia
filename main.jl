include("structures.jl")

queue = PendingQueue(nothing, nothing, 0)
tree = PriorityTree(nothing, 0)
completed = CompletedList(nothing, nothing, 0)

println("Gestor de tareas iniciado")
println("Cola: ", queue.size, " tareas")
println("Arbol: ", tree.size, " tareas")
println("Completadas: ", completed.size, " tareas")