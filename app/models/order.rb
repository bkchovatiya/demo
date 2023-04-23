class Order < ApplicationRecord
  include AASM

  belongs_to :customer

  has_many :line_items
  has_many :products, through: :line_items

  aasm(:state) do
    state :pending, initial: true
    state :completed

    event :complete do
      transitions from: :pending, to: :completed
    end
  end

end
