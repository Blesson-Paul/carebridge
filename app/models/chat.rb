class Chat < ApplicationRecord
  belongs_to :condition
  belongs_to :user
  has_many :messages, dependent: :destroy
end
