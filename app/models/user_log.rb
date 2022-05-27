class UserLog < ApplicationRecord
  belongs_to :user
  belongs_to :account


  def self.add_log(user_id, account_id, action)
    create(user_id: user_id, account_id: account_id, action: action)
  end

private

  ## def method_name
  ##
  ## end

end
