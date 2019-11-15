class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :resources_tasks, class_name: 'ResourceTask'
  has_many :resources, through: :resources_tasks, dependent: :destroy

  enum status: ['En Proceso', 'Pendiente', 'Concluido']
  validates :name,  presence: true, length: { maximum: 30 }
  validates :detail, :start_date, :finish_date, :status, presence: true

  def total_price
    total_price = 0
    self.resources.each do |resource|
      total_price += resource.price
    end
      total_price
  end
end
