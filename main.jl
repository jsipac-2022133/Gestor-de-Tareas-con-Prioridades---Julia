include("manager.jl")

manager = create_manager()

add_task(manager, "Comprar insumos", 2)
add_task(manager, "Llamar al cliente", 1)
add_task(manager, "Enviar reporte", 3)
add_task(manager, "Actualizar sistema", 5)
add_task(manager, "Revisar correos", 1)
add_task(manager, "Preparar presentacion", 4)
add_task(manager, "Confirmar reunion", 2)

process_next(manager)
process_next(manager)
process_next(manager)

resultados = find_by_priority(manager, 2)
println("Tareas con prioridad 2:")
for t in resultados
    println("  ", t.title)
end

tarea = find_completed_by_id(manager, 2)
if tarea !== nothing
    println("Completada encontrada: ", tarea.title)
end

full_report(manager)
