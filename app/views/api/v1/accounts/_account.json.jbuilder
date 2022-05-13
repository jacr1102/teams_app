json.status :ok
json.extract! account, :id, :created_at, :updated_at
json.url api_v1_account_url(account, format: :json)
json.team do
  account.team.each do |user|
    json.partial! "api/v1/users/user", user: user
  end
end