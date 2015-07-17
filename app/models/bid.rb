class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :amount, presence: true, numericality: { only_integer: true }
  validate :is_highest_bid, on: :creation

  def is_highest_bid(record)
    errors.add(:amount, "must be higher than current bid") unless record.auction.current_bid < record.amount
  end
end
