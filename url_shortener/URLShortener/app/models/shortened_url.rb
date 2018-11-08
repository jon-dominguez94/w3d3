# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true
  validates :short_url, presence: true, uniqueness: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visitors,
    primary: :id,
    foreign_key: :url_id,
    class_name: :Visit

  def self.random_code
    s = SecureRandom.urlsafe_base64
  end

  def create!(l_url, user)
    s = ShortenedUrl.new(long_url: l_url, short_url: ShortenedUrl.random_code, user_id: user.id) unless ShortenedUrl.exists?({short_url: s})
    s.save
  end

  def num_clicks
    visitors.count
  end

  def num_uniques
    visitors.uniq
  end

  def num_recent_uniques

  end
end
