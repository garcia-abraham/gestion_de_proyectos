class GroupProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  enum role: [:collaborator, :administrator]
end
