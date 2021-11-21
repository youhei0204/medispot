class Notification < ApplicationRecord
  belongs_to :user
  validates :request_type, numericality: { only_integer: true }
  validates :new_flag, inclusion: { in: [true, false] }
end
