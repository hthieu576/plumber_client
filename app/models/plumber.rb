# == Schema Information
#
# Table name: plumbers
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  address    :string(255)
#  vehicles   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Plumber < ApplicationRecord
  has_paper_trail

  MOVING_SPEED_PER_HOUR = { walk: 5, bike: 15, bus: 40, car: 60 }.freeze

  has_many :jobs, dependent: :destroy
  has_many :clients, through: :jobs, dependent: :destroy

  validates :name, :address, :vehicles, presence: true

  scope :available, -> { includes(:jobs).where(jobs: { plumber_id: nil }).or(Plumber.includes(:jobs).where(jobs: { status: :finished })) }

  enum vehicles: { walk: 0, bike: 1, bus: 2, car: 3 }
end
