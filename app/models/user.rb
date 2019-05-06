class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name, presence: true,
             length: {maximum: Settings.app.user.name_max_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
             length: {maximum: Settings.app.user.email_max_length},
                      format: {with: VALID_EMAIL_REGEX},
                      uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
             length: {minimum: Settings.app.user.password_min_length}
end
