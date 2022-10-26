# == Schema Information
#
# Table name: jobs
#
#  id          :bigint           not null, primary key
#  description :string(255)
#  client_id   :bigint           not null
#  plumber_id  :bigint           not null
#  time_period :datetime
#  status      :integer          default("assigned")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Job < ApplicationRecord
  has_paper_trail

  belongs_to :client
  belongs_to :plumber

  validates :description, :client_id, :plumber_id, :time_period, presence: true

  scope :allocated, -> { includes(:client, :plumber).where(status: :assigned).where("time_period >= ?", DateTime.current) }

  enum status: { assigned: 0, finished: 1 }

  def estimate_distance
    # This case makes performance slow. I temporarily don't fix it.
    client_coordinate = Geocoder.search(client.address).first&.coordinates
    return unless client_coordinate

    plumber_coordinate = Geocoder.search(plumber.address).first&.coordinates
    return unless plumber_coordinate

    distance = Geocoder::Calculations.distance_between(client_coordinate, plumber_coordinate, units: :km)
    distance.round(3)
  end

  def estimate_time_by_vehicles
    return unless estimate_distance

    estimate_minutes = (estimate_distance * 60).to_f / Plumber::MOVING_SPEED_PER_HOUR[plumber.vehicles.to_sym]
    estimate_minutes.round(3)
  end
end
