# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  session_token   :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :email, :session_token, :password_digest, presence: true
  after_initialize :ensure_session_token
  
  has_many(
  :notes,
  class_name: "Note",
  foreign_key: :user_id,
  primary_key: :id
  )
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    
    user.is_password?(password) ? user : nil
  end
      
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
