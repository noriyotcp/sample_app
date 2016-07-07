class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  delegate :name, to: :user, prefix: true

  private

  def picture_size
    return unless picture.size > 5.megabytes
    errors.add(:picture, 'should be less than 5MB')
  end
end
