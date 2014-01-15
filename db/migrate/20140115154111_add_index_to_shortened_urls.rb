class AddIndexToShortenedUrls < ActiveRecord::Migration
  def change
    add_index(:shortened_urls, :submitter_id)
  end
end
