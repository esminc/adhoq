# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :adhoq_query, class: 'Adhoq::Query' do
    name        'A query'
    description 'Simple simple SELECT'
    query       'SELECT 1'
  end
end
