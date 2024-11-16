class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # Returns the hash digest of the given string.
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Generates a new random token to be used, for example, in sessions or email confirmations.
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    # Creates a 'remember me' token for the user and stores its hashed version in the database.
    # Typically used for persistent login sessions.
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Removes the user's remember digest from the database, effectively logging them out of persistent sessions.
    def forget
      update_attribute(:remember_digest, nil)
    end

    # Checks if the provided token matches the digest stored for a given attribute (e.g., remember_token).
    # Used to verify that a token is valid, such as checking if the remember_token is correct.
    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end


  private
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
end
