class Profile < ApplicationRecord
  enum english_level: [:no_experience, :a2, :b1, :b2, :c1, :c2]

  belongs_to :user

end
