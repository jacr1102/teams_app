class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist


  validates :first_name, presence: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  validates :username, presence: true, uniqueness: true, on: :create
  validates :password, presence: true, on: :create

  belongs_to :role

  has_one :profile, dependent: :destroy


  has_many :accounts
  has_many :logs, dependent: :destroy
  has_many :team_members
  has_many :projects, source: :accounts, through: :team_members

  accepts_nested_attributes_for :profile
  after_initialize :set_default_role

  def role_slugs
    role_slugs ||= roles.pluck(:name)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  Role.slugs.each do |slug|
    define_method "is_#{slug}?" do
      role.slug == slug
    end
  end

private

  def set_default_role
    self.role ||= Role.find_by_name :user
  end

end