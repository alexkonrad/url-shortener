class ShortenedUrl < ActiveRecord::Base

  attr_accessible :submitter_id, :long_url, :short_url

  belongs_to(
  :submitter,
  :class_name => "User",
  :foreign_key => :submitter_id,
  :primary_key => :id
  )

  has_many(
  :visits,
  :class_name => "Visit",
  :foreign_key => :shortened_url_id,
  :primary_key => :id
  )

  has_many :visitors, :through => :visits, :source => :visitor

  def self.random_code
    SecureRandom.urlsafe_base64
  end

  def self.create_for_user_and_long_url!(submitter, long_url)
    short_url = ShortenedUrl.random_code

    until where("short_url != ?", short_url)
      short_url = ShortenedUrl.random_code
    end

    submitter_id = submitter.id

    new_url = ShortenedUrl.create!(:submitter_id => submitter_id,
                         :long_url => long_url,
                         :short_url => short_url)

    Visit.record_visit!(submitter_id, new_url.id)
  end

end