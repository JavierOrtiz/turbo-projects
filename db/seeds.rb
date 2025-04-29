puts "⏳ Dropping database..."
Task.destroy_all
Project.destroy_all

puts "🌱 Creating 200 projects with between 30 to 40 tasks each..."

200.times do |i|
  project = Project.create!(
    title:       Faker::App.name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    status:      Project.statuses.keys.sample
  )

  project_tasks = []
  rand(30..40).times do
    project_tasks << project.tasks.create!(
      content:   Faker::Lorem.sentence(word_count: 5),
      status:  Task.statuses.keys.sample,
      expires_at: Faker::Time.between(from: Time.current, to: 2.days.from_now)
    )
  end

  num_parents = (project_tasks.size * 0.4).floor
  parent_tasks = project_tasks.sample(num_parents)
  project_tasks.each do |task|
    next if parent_tasks.include?(task)

    task.update!(task: parent_tasks.sample)
  end

  print "." if (i % 10).zero?
end

puts "\n✅ Seed completed!"
