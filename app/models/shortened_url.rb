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
    begin
      short_url = SecureRandom.urlsafe_base64
    end until !exists?(short_url: short_url)

    short_url
  end

  def self.create_for_user_and_long_url!(submitter, long_url)
    short_url = ShortenedUrl.random_code

    submitter_id = submitter.id

    new_url = ShortenedUrl.create!(:submitter_id => submitter_id,
                         :long_url => long_url,
                         :short_url => short_url)
    new_url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visits.distinct.count
  end

  def num_recent_uniques
    visits.where(created_at: 10.minutes.ago..Time.now).uniq.count
  end

end