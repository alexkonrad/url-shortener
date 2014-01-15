class Visit < ActiveRecord::Base

  attr_accessible :user_id, :shortened_url_id

  belongs_to(
  :visitor,
  :class_name => "User",
  :foreign_key => :user_id,
  :primary_key => :id)

  belongs_to(
  :short_url,
  :class_name => "ShortenedUrl",
  :foreign_key => :shortened_url_id,
  :primary_key => :id)

  def self.record_visit!(user_id, shortened_url_id)

    Visit.create!(:user_id => user_id,
          :shortened_url_id => shortened_url_id)
  end

end