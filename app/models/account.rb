class Account < ApplicationRecord
  validates :name, presence: true, uniqueness: true, on: :create
  validates :client_name, presence: true, uniqueness: true, on: :create
  validates :user, presence: true, on: :create

  belongs_to :user

  has_many :team_members
  has_many :team, source: :user, through: :team_members

end
