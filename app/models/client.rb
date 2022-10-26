# == Schema Information
#
# Table name: clients
#
#  id           :bigint           not null, primary key
#  name         :string(255)
#  address      :string(255)
#  age          :integer
#  private_note :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Client < ApplicationRecord
  has_paper_trail

  has_many :plumbers, through: :jobs, dependent: :destroy
  has_many :jobs, dependent: :destroy

  validates :name, :address, :age, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 10 }
end
