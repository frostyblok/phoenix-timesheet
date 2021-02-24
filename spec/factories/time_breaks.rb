FactoryBot.define do
  factory :time_break do
    name { "MyString" }
    start_time { "12:00" }
    end_time { "13:00" }
    time_sheet { nil }
  end
end
