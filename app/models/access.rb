class Access < ApplicationRecord
  
  validates :shared_to_id, :sharer_id, :level, :shareable_type, :shareable_id,  presence: true

  enum level: [:read, :write, :owner]
  belongs_to :note
  has_many :accesses, as: :shareable, dependent: :destroy
  belongs_to :shareable, polymorphic: true

  def source
    User.find_by(id: self.sharer_id)
  end

  def sink
    User.find_by(id: self.shared_to_id)
  end


end
