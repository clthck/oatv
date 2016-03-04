class Video < ActiveRecord::Base
  belongs_to :match
  has_many :clips, dependent: :destroy
  has_many :video_questions

  validates :url, uniqueness: true
  validates :ytv_id, uniqueness: true

  before_create :get_video_info

  protected

  def get_video_info
  	ytv = Yt::Video.new url: self.url
  	self.ytv_id = ytv.id
  	[:title, :duration, :thumbnail_url].each do |attr_method|
  		self.send "#{attr_method.to_s}=", ytv.send(attr_method)
  	end
  end
end
