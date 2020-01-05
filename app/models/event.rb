class Event < ApplicationRecord
  validates :title, presence: true
  validates :candidate_date, presence: true
  validates :url, presence: true, uniqueness: true
  
  def to_param
    url
  end
end
