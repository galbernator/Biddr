class User < ActiveRecord::Base
  has_secure_password

  has_many :auctions, dependent: :destroy
  has_many :bids, dependent: :destroy

  validates :first_name, presence: true
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true,
              format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, presence: true, on: :creation
  validates :password_confrirmation, presence: true, on: :creation
end
