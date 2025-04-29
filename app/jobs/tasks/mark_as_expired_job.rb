class Tasks::MarkAsExpiredJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find_by(id: task_id)
    return unless task&.expiration_due?

    task.expired!
  end
end
