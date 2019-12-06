class Project < ApplicationRecord
  has_many :group_projects, dependent: :destroy
  has_many :users, through: :group_projects
  has_many :tasks

  enum status: ['En Proceso', 'Pendiente', 'Concluido']
  enum filters: ['Costo','Miembros','Porcentaje']
  validates :name,  presence: true, length: { maximum: 30 }
  validates :detail, :start_date, :finish_date, :status, presence: true

  def total_price
    total_price = 0
    self.tasks.each do |task|
      total_price += task.total_price
    end
     total_price
  end

  def average_percentage
    self.tasks.empty? ? 0 : self.tasks.map(&:percentage).sum / self.tasks.count
  end

  def total_members
    self.group_projects.count
  end
end
