# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord

    validates :username, presence: true
    validates :password, length: { minimum: 6}, allow_nil: true

    has_many :posts
    has_many :subs

    
    after_initialize :ensure_session_token

    attr_reader :password

    def find_by_credentials(username, password)
        user = User.find_by(username: username)
        return user unless user && user.is_password?(password)
        user
    end

    def is_password?(password)
        encrypted_password = BCrypt::Password.new(self.password_digest)
        encrypted_password.is_password?(password)
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save
        self.session_token
    end


end
