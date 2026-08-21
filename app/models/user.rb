class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :chats, dependent: :destroy
  has_many :messages, through: :chats, dependent: :destroy
  has_many :conditions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :date_of_birth, :gender, presence: true
  validate :date_of_birth_must_be_valid
  private
  def date_of_birth_must_be_valid
    return if date_of_birth.blank?
    if date_of_birth > Date.current
      errors.add(:date_of_birth, "cannot be in the future")
    elsif date_of_birth < 120.years.ago.to_date
      errors.add(:date_of_birth, "must be a realistic date")
    end
  end
end
