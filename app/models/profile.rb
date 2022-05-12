class Profile < ApplicationRecord
  enum english_level: [:none, :a2, :b1, :b2, :c1, :c2]
end
