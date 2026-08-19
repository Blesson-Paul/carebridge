class Condition < ApplicationRecord
  has_one :chat
  belongs_to :user
  has_many :messages, through: :chat
end
