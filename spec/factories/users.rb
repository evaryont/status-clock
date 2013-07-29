FactoryGirl.define do
  factory :user do
    provider "google_oauth2"
    uid "116582821578363186745"
    name "Tom"

    status_1 'Work'
    status_2 'Home'
    status_3 'Play'
    status_4 'Mall'
    status_5 'Sleep'
    status_6 'School'

    token_code 'ab12.XYZ3CS4YjRPU4oMGC3M66uvYEZ8YfqxkrZ0BGtTc8e3wMl4'
    expires_at Time.now + 1.week
  end
end
