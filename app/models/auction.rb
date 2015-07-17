class Auction < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :title, presence: true
  validates :details, presence: true
  validates :end_date, presence: true
  validates :reserve_price, presence: true

  include AASM

  # AASM will use aasm_state database field by default to store the state
aasm whiny_transitions: false do
  state :published, initial: true
  state :reserve_not_met
  state :cancelled
  state :won
  state :reserve_met

  # event is a method from AASM takes an arguement (event name)
  # and a block of code
  event :bid_recieved do
    transitions({from: :published, to: :reserve_not_met})
  end

  event :reserve_met do
    transitions from: [:published, :reserve_not_met], to: :reserve_met
  end

  event :cancel do
    transitions from: :published, to: :cancelled
  end

  event :win do
    transitions from: :reserve_met, to: :won
  end
end

end
