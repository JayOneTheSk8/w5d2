# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_session_token
  attr_reader :password

  def self.find_by_credentials(passed_user, passed_word)
    user = User.find_by(username: passed_user)
    return user if user && user.is_password?(passed_word)
    nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
  end

  def is_password?(passed_word)
    BCrypt::Password.new(self.password_digest).is_password?(passed_word)
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
