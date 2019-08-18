class User < ActiveRecord::Base
    has_secure_password
    
    validates :email, presence: true, uniqueness: true 
    validates :password, confirmation: true
    validates :password, presence: true,
        unless: ->(b){ b.password.blank? } 
    validates :password, length: { in: 6..20 }

    has_many :posts
    validates_associated :posts
end 