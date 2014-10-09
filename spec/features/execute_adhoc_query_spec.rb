feature 'Golden-path: execute adhoc query' do
  def table_contant(table_el)
    table_el.all('tr').map {|row| row.all('th, td').map(&:text) }
  end

  scenario 'Visit root, input query and generate report then we get a report' do
    visit '/adhoq'

    fill_in 'Name',        with: 'My new query'
    fill_in 'Description', with: 'Description about this query'
    fill_in 'Query',       with: 'SELECT 42 AS "answer number", "Hello adhoq" AS message'

    first('a.js-preview-button').click
    within('.js-preview-result') do
      expect(page).to have_content('Hello')

      expect(table_contant(first('table'))).to eq [
        ['answer number', 'message'],
        ['42',            'Hello adhoq']
      ]
    end
  end
end
