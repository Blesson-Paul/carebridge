class Condition < ApplicationRecord
  has_one :chat , dependent: :destroy
  belongs_to :user
  has_many :messages, through: :chat
end
