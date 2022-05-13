json.status :ok

json.users do
  json.partial! "api/v1/users/user", user: @user
end
