# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  band_id    :integer          not null
#

class Album < ActiveRecord::Base
  ALBUM_TYPES = ["Studio", "Live"]
  validates :name, :band_id, presence: true
  validates :album_type, inclusion: { in: ALBUM_TYPES }
  
  belongs_to(
  :band,
  class_name: "Band",
  foreign_key: :band_id,
  primary_key: :id,
  )
  
  has_many(
  :tracks,
  class_name: "Track",
  foreign_key: :album_id,
  primary_key: :id,
  dependent: :destroy
  )
end
