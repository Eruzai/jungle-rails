class User < ApplicationRecord

  has_secure_password

  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    formattedEmail = email.strip.downcase
    user = User.find_by_email(formattedEmail)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
