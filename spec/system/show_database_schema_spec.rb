feature 'Can see database schema at editing form', type: :system do
  include SystemSpecHelper

  scenario 'See database schema' do
    visit adhoq.root_path

    click_on 'Show tables'

    within('#current-tables') do
      expect(page).to have_text('Current tables')
      expect(page).to have_text(/Version \d+/)

      main_names_and_types = table_contant('li[data-table-name="adhoq_queries"] table').from(2).map {|row| row[1, 2] }.take(3)

      expect(main_names_and_types).to eq [
        ["name",        "string"],
        ["description", "string"],
        ["query",       "text"],
      ]

      # NOTE spec/dummy/config/initializers/adhoq.rb:5
      expect(page).not_to have_text('secret_tables')
    end
  end
end

