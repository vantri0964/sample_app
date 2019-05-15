class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true,
             length: {maximum: Settings.app.micropost.content_max}
  default_scope ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  scope :find_user_id, ->(id){where "user_id = ?", id}

  def picture_size
    return unless picture.size > Settings.app.micropost.fivemicropost.megabytes
    errors.add :picture, t("models.micropost.bug_mb")
  end
end
