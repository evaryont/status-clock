# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status do
    text "MyString"
    lcd 1
    user nil
  end
end
