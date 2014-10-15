feature 'Can see database schema at editing form' do
  include FeatureSpecHelper

  scenario 'See database schema' do
    visit adhoq.root_path

    click_on 'Tables'

    within('.tab-content') do
      expect(page).to have_text('Current database schema')

      main_names_and_types = table_contant('li[data-table-name="adhoq_queries"] table').from(2).map {|row| row[1, 2] }.take(3)

      expect(main_names_and_types).to eq [
        ["name",        "string"],
        ["description", "string"],
        ["query",       "text"],
      ]
    end
  end
end

