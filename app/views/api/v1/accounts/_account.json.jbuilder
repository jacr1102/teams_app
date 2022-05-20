json.extract! account, :id,:name,:user_id, :client_name, :created_at, :updated_at
json.url api_v1_account_url(account, format: :json)
json.account_manager account.user.full_name
json.team do
  json.array! account.team, partial: "api/v1/users/user", as: :user
end

json.team_ids do
  json.array! account.team.collect &:id
end
