class User < ActiveRecord::Base

  attr_accessible :email

  has_many(
  :submitted_urls,
  :class_name  => "ShortenedUrl",
  :foreign_key => :submitter_id,
  :primary_key => :id
  )

  validates :email, :presence => true, :uniqueness => true

end