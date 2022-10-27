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
FactoryBot.define do
  factory :plumber do
    name { Faker::Name.name }
    address { Faker::Address.city }
    vehicles { [:walk, :bike, :bus, :car].sample }
  end
end
