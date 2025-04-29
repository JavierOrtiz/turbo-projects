class Tasks::CheckExpirationsJob < ApplicationJob
  queue_as :default

  def perform
    Task.expiring_soon.find_each do |task|
      Tasks::MarkAsExpiredJob.set(wait_until: task.expires_at).perform_later(task.id)
    end
  end
end
