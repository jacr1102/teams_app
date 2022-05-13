class Log < ApplicationRecord
  belongs_to :user
  belongs_to :account_from, class_name: "Account", foreign_key: "account_from_id"
  belongs_to :account_to, class_name: "Account", foreign_key: "account_to_id"
end
