class Project < ApplicationRecord
  enum :status, [:active, :archived]

  validates :title, presence: true
  validates :description, presence: true
end
