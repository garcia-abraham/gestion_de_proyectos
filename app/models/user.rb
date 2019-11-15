class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :adm]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  has_many :tasks, dependent: :destroy
  has_many :group_projects, dependent: :destroy
  has_many :projects, through: :group_projects

  private

  def self.all_except(user)
    where.not(id: user)
  end

end
