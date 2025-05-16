class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  # Validations
  validates :creator_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :date, presence: true
  validate :date_cannot_be_in_the_past

  private
  def date_cannot_be_in_the_past
    if date.present? && date < Time.current
      errors.add(:date, "can't be in the past")
    end
  end
end
