json.id user.id
json.extract! user, :first_name, :last_name, :username
json.name user.full_name
json.email user.email
json.role user.role.name.capitalize
json.role_id user.role_id
if user.profile.present?
  json.profile_attributes do
    json.extract! user.profile, :id, :english_level, :technical_experience, :cv_link
  end
end

json.url api_v1_user_url(user, format: :json)
json.extract! user, :created_at, :updated_at