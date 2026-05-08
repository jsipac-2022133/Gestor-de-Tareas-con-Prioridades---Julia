include("manager.jl")

manager = create_manager()

add_task(manager, "Comprar insumos", 2)
add_task(manager, "Llamar al cliente", 1)
add_task(manager, "Enviar reporte", 3)
add_task(manager, "Actualizar sistema", 5)
add_task(manager, "Revisar correos", 1)

show_status(manager)
show_by_priority(manager)

println("Procesando tareas...")
process_next(manager)
process_next(manager)

show_status(manager)

println("Completadas:")
print_completed(manager.completed)
