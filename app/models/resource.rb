class Resource < ApplicationRecord
  has_many :resources_tasks, class_name: 'ResourceTask'
  has_many :task, through: :resources_tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :price, presence: true
end
