class Condition < ApplicationRecord
  has_one :chat
  has_one :user, through: :chat
  has_many :messages, through: :chat

  validates :description, :symptoms, :diagnosed_on, presence: true
end
