class Account < ApplicationRecord
  validates :name, presence: true, uniqueness: true, on: :create
  validates :client_name, presence: true, uniqueness: true, on: :create
  validates :user, presence: true, on: :create

  belongs_to :user

  has_many :user_logs, dependent: :destroy
  has_many :team_members, dependent: :destroy
  has_many :team, source: :user, through: :team_members, after_add: :start_log, after_remove: :end_log


  def start_log(user)
    UserLog.add_log(user.id, id, "start")
  end

  def end_log(user)
    UserLog.add_log(user.id, id, "end")
  end

end
