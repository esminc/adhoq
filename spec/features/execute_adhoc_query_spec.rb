feature 'Golden-path: execute adhoc query' do
  include FeatureSpecHelper

  scenario 'Visit root, input query and generate report then we get a report' do
    visit '/adhoq'

    fill_in 'Name',        with: 'My new query'
    fill_in 'Description', with: 'Description about this query'
    fill_in 'Query',       with: 'SELECT 42 AS "answer number", "Hello adhoq" AS message'

    first('a.js-preview-button').click
    within '.js-preview-result' do
      expect(page).to have_content('Hello')

      expect(table_contant('table')).to eq [
        ['answer number', 'message'],
        ['42',            'Hello adhoq']
      ]
    end

    click_on 'Save'

    within '.new-execution' do
      select   'xlsx', from: 'Report format'
      click_on 'Create report'
    end

    within '.past-executions' do
      expect(table_contant('table.executions').size).to eq 2
    end

    # NOTE xlsx parser casts "42" to 42.0
    expect(Adhoq::Report.order('id DESC').first.data).to have_values_in_xlsx_sheet([
      ['answer number', 'message'],
      [42.0,            'Hello adhoq']
    ])
  end
end
