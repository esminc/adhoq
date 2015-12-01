feature 'Golden-path: execute adhoc query' do
  include FeatureSpecHelper

  def create_query(query_text, preview: true)
    fill_in 'New query', with: query_text

    if preview
      click_on 'Preview'
      click_on 'Refresh'
      within '.js-preview-result' do
        expect(page).to have_content('Hello')

        expect(table_contant('table')).to eq [
          ['answer number', 'message'],
          ['42',            'Hello adhoq']
        ]
      end
    end

    click_on 'Save as...'
    fill_in  'Name',        with: 'My new query'
    fill_in  'Description', with: 'Description about this query'

    click_on 'Save'
    expect(page).to have_content('Create report')
  end

  def create_simple_query
    create_query('SELECT 42 AS "answer number", "Hello adhoq" AS message')
  end

  def create_placeholdered_query
    create_query('SELECT $num AS "answer number", "Hello adhoq" AS message', preview: false)
  end

  scenario 'Visit root, input query and click explain then we get a EXPLAIN query result' do
    visit '/adhoq'

    fill_in 'New query', with: 'SELECT * from adhoq_queries'

    click_on 'Explain'
    click_on 'Refresh'
    expect(find('.js-explain-result')).to have_content(/SCAN TABLE adhoq_querie/)
  end

  scenario 'Visit root, input query and generate report then we get a report' do
    visit '/adhoq'

    create_simple_query

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

  scenario 'Visit root, input placeholdered query and generate report then we get a report' do
    visit '/adhoq'

    create_placeholdered_query

    within '.new-execution' do
      select   'xlsx', from: 'Report format'
      fill_in  'num',  with: "10"
      click_on 'Create report'
    end

    within '.past-executions' do
      expect(table_contant('table.executions').size).to eq 2
    end

    # NOTE xlsx parser casts "42" to 42.0
    expect(Adhoq::Report.order('id DESC').first.data).to have_values_in_xlsx_sheet([
      ['answer number', 'message'],
      [10.0,            'Hello adhoq']
    ])
  end

  if defined?(ActiveJob)
    context "async_execution feature is ON", async_execution: true,  active_job_test_adapter: true do
      scenario 'Visit root, input query and generate report then we get a report' do
        visit '/adhoq'

        create_simple_query

        expect {
          within '.new-execution' do
            select   'xlsx', from: 'Report format'
            click_on 'Create report'
          end
        }.to change { Adhoq::ExecuteJob.queue_adapter.performed_jobs.size }.from(0).to(1)

        within '.past-executions' do
          expect(table_contant('table.executions').size).to eq 2
        end

        # NOTE xlsx parser casts "42" to 42.0
        expect(Adhoq::Report.order('id DESC').first.data).to have_values_in_xlsx_sheet([
          ['answer number', 'message'],
          [42.0,            'Hello adhoq']
        ])
      end

      scenario 'Visit root, input placeholdered query and generate report then we get a report' do
        visit '/adhoq'

        create_placeholdered_query

        expect {
          within '.new-execution' do
            select   'xlsx', from: 'Report format'
            fill_in  'num',  with: "10"
            click_on 'Create report'
          end
        }.to change { Adhoq::ExecuteJob.queue_adapter.performed_jobs.size }.from(0).to(1)

        within '.past-executions' do
          expect(table_contant('table.executions').size).to eq 2
        end

        # NOTE xlsx parser casts "42" to 42.0
        expect(Adhoq::Report.order('id DESC').first.data).to have_values_in_xlsx_sheet([
          ['answer number', 'message'],
          [10.0,            'Hello adhoq']
        ])
      end
    end

    context "async_execution feature is OFF", async_execution: false,  active_job_test_adapter: true do
      scenario 'Visit root, input query and generate report then we get a report' do
        visit '/adhoq'

        create_simple_query

        expect {
          within '.new-execution' do
            select   'xlsx', from: 'Report format'
            click_on 'Create report'
          end
        }.not_to change { Adhoq::ExecuteJob.queue_adapter.performed_jobs.size }.from(0)

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
  end
end
