class Condition < ApplicationRecord
  has_one :chat , dependent: :destroy
  belongs_to :user
  has_many :messages, through: :chat

  validates :description, :symptoms, :diagnosed_on, presence: true
  validate :diagnosed_on_cannot_be_in_future

  private
  def diagnosed_on_cannot_be_in_future
    return if diagnosed_on.blank?
    if diagnosed_on > Date.current
      errors.add(:diagnosed_on, "cannot be in the future")
    elsif user&.date_of_birth.present? && diagnosed_on < user.date_of_birth
      errors.add(:diagnosed_on, "cannot be before your date of birth")
    end
  end
end
