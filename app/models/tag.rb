class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :notes, through: :taggings

  def self.note_count(tag_name)
    Tag.find_by(name: tag_name.strip).notes.count
  end

end
