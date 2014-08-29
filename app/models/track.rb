# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  album_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  TRACK_TYPES = ["Regular", "Bonus"]
  validates :name, :album_id, presence: true
  validates :track_type, inclusion: { in: TRACK_TYPES }
  
  belongs_to(
  :album,
  class_name: "Album",
  foreign_key: :album_id,
  primary_key: :id,
  )
  
  has_one(
  :band,
  through: :album,
  source: :band
  )
  
  has_many(
  :notes,
  class_name: "Note",
  foreign_key: :track_id,
  primary_key: :id
  )
end
