class Task < ApplicationRecord
  belongs_to :project, inverse_of: :tasks
  belongs_to :task, optional: true, inverse_of: :subtasks
  alias :parent :task
  has_many :subtasks, class_name: "Task", dependent: :nullify, inverse_of: :task

  enum :status, [ :pending, :on_review, :completed, :expired ]

  before_validation :set_expires_at, on: :create

  scope :not_subtasks,  -> { where(task_id: nil) }
  scope :expired,       -> { where(expires_at: ..Time.current) }
  scope :active,        -> { not_expired.where.not(expires_at: ..Time.current) }
  scope :expiring_soon, ->(window = 12.hour) {
    where(expires_at: Time.current..window.from_now)
  }

  validates :content, presence: true
  validates :expires_at, presence: true

  after_update_commit :mark_expired_subtasks, if: -> { saved_change_to_status? && expired? }

  def expiration_due?(threshold = 12.hours.from_now)
    !expired? && expires_at <= threshold
  end

  private

  def set_expires_at
    self.expires_at ||= 6.months.from_now
  end

  def mark_expired_subtasks
    subtasks.find_each do |subtask|
      next if subtask.expired?

      subtask.expired!
    end
  end
end
