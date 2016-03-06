class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	belongs_to :role
	before_create :set_default_role

	belongs_to :club
	accepts_nested_attributes_for :club

	has_one :profile, dependent: :destroy
	accepts_nested_attributes_for :profile

	has_many :clip_players
	has_many :clips, through: :clip_players

	def is?(role)
		self.role.name == role.to_s
	end

	def display_name
		self.profile && self.profile.full_name? ? self.profile.full_name : self.email
	end

	def avatar
		self.profile ? self.profile.avatar.url(:thumb) : 'default_avatar'
	end

	private

	def set_default_role
		self.role ||= Role.find_by(name: 'player')
	end
end
