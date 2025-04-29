class Task < ApplicationRecord
  belongs_to :project, inverse_of: :tasks
  belongs_to :task, optional: true, inverse_of: :subtasks
  alias :parent :task
  has_many :subtasks, class_name: "Task", dependent: :nullify, inverse_of: :task

  enum :status, [ :active, :on_review, :completed ]

  before_validation :set_expires_at, on: :create

  scope :not_subtasks,   -> { where(task_id: nil) }
  scope :expired,   -> { where(expires_at: ..Time.current) }
  scope :active,    -> { where.not(expires_at: ..Time.current) }

  validates :content, presence: true
  validates :expires_at, presence: true

  private

  def set_expires_at
    self.expires_at ||= 6.months.from_now
  end
end
