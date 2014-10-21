# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :adhoq_query, class: 'Adhoq::Query' do
    name        'A query'
    description 'Simple simple SELECT'
    query       'SELECT 1'

    trait :complex do
      name        'adhoq current use'
      description 'Simple analysys: count execution per query'
      query <<-SQL.strip_heredoc
        SELECT
          q.id
         ,q.name
         ,(
            SELECT COUNT(*)
            FROM  adhoq_executions exec
            INNER JOIN adhoq_reports r ON r.execution_id = exec.id
            WHERE exec.query_id = q.id
          ) AS use_count
        FROM
          adhoq_queries q
        ORDER BY
          use_count DESC, id ASC
      SQL
    end

    trait :greeting do
      name        'greeting'
      description 'Static query for testing data'
      query       'SELECT "hello" AS name ,"English greeting message" AS description'
    end
  end
end
