class Resource < ApplicationRecord
  has_many :resources_tasks, class_name: 'ResourceTask'
  has_many :task, through: :resources_tasks
  validates :name,  presence: true, length: { maximum: 30 }
  validates :quantity, :price, presence: true
end
