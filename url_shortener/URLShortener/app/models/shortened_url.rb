# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true
  validates :short_url, presence: true, uniqueness: true

  def self.random_code
    s = SecureRandom.urlsafe_base64
  end

  def new_create(l_url, u_id)
    s = ShortenedUrl.new(long_url: l_url, short_url: ShortenedUrl.random_code, user_id: u_id) unless ShortenedUrl.exists?({short_url: s})
    s.save
  end
end
