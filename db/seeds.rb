require 'faker'

puts "⏳ Borrando datos existentes..."
Task.destroy_all
Project.destroy_all

puts "🌱 Creando 100 proyectos con entre 20 y 30 tareas cada uno..."

100.times do |i|
  project = Project.create!(
    title:       Faker::App.name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    status:      Project.statuses.keys.sample
  )

  project_tasks = []
  rand(20..30).times do
    project_tasks << project.tasks.create!(
      content:   Faker::Lorem.sentence(word_count: 5),
      status:  Task.statuses.keys.sample
    )
  end

  project_tasks.each do |task|
    if project_tasks.size > 1 && rand < 0.3
      parent = project_tasks.sample
      parent = project_tasks.sample while parent == task
      task.update!(task: parent)
    end
  end

  print "." if (i % 10).zero?
end

puts "\n✅ Seeds cargados correctamente."