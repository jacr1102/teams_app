json.user_logs do
  json.array! @logs do |log|
    json.extract! log, :id, :created_at
    json.action log.action
    json.user_name log.user.full_name
    json.client_name log.account.client_name
  end
end