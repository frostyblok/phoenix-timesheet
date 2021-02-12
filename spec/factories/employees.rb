FactoryBot.define do
  factory :employee do
    name { Faker::Movies::StarWars.character }
  end
end
