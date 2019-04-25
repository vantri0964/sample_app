class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true,
             length: {maximum: Settings.app.micropost.content_max}
  default_scope ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  lamda = lambda do |id_of_user|
    following_ids = "SELECT followed_id  FROM
    relationships WHERE  follower_id = :user_id"
    where "user_id IN (#{following_ids})
    OR user_id = :user_id", user_id: id_of_user
  end
  scope :feed_all, ->(id_of_user){lamda.call(id_of_user)}

  def picture_size
    return unless picture.size > Settings.app.micropost.fivemicropost.megabytes
    errors.add :picture, t("models.micropost.bug_mb")
  end
end
