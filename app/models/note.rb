class Note < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :accesses, as: :shareable, dependent: :destroy

  def all_tags=(names)
      self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip.downcase).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(",")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).notes.order(created_at: :desc)
  end

  def self.shared(user)
    Access.where(shared_to_id: user.id).map(&:note)
  end

  def self.owner(user)
    Note.where(user: user)
  end

  def creator?(user)
    self.user.eql?(user)
  end

  def share_allowed?(user)
    self.user.eql?(user) || Access.find_by(note_id: self.id, shared_to_id: user.id, level: "owner").present?
  end

  def edit_allowed?(user)
    self.user.eql?(user) || Access.find_by(note_id: self.id, shared_to_id: user.id, level: "owner").present? || 
    Access.find_by(note_id: self.id, shared_to_id: user.id, level: "write").present?
  end

  def read_allowed?(user)
    self.user.eql?(user) || Access.find_by(note_id: self.id, shared_to_id: user.id).present?
  end

end
