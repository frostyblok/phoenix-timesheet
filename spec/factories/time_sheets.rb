FactoryBot.define do
  factory :time_sheet do
    billable_rate { "9.99" }
    company { "MTN" }
    date { "2021-02-11" }
    start_time { "06:29" }
    end_time { "14:29" }
    employee { nil }
  end
end
