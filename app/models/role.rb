class Role < ApplicationRecord
  validates :name, presence: true

  has_many :users

  def slug
    name.parameterize.underscore
  end

  def self.slugs
    all.pluck(:name).map{ |role_name| role_name.parameterize.underscore }
  end
end
