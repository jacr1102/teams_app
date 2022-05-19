json.id user.id
json.name user.full_name
json.email user.email
json.role user.role.name.capitalize
json.extract! user.profile, :english_level, :technical_experience if user.profile.present?
json.url api_v1_user_url(user, format: :json)
json.extract! user, :created_at, :updated_at