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
FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    address { Faker::Address.city }
    age { 30 }
    private_note { Faker::Lorem.sentence }
  end
end
