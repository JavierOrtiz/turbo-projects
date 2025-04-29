class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy,
           inverse_of: :project
  has_many :active_tasks,
           -> { active },
           class_name: "Task",
           inverse_of: :project

  enum :status, [ :active, :archived ]

  validates :title, presence: true
  validates :description, presence: true
end
