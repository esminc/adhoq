feature 'Golden-path: execute adhoc query' do
  include FeatureSpecHelper

  def create_test_query
    fill_in 'New query', with: 'SELECT 42 AS "answer number", "Hello adhoq" AS message'

    click_on 'Preview'
    click_on 'Refresh'
    within '.js-preview-result' do
      expect(page).to have_content('Hello')

      expect(table_contant('table')).to eq [
        ['answer number', 'message'],
        ['42',            'Hello adhoq']
      ]
    end

    click_on 'Save as...'
    fill_in  'Name',        with: 'My new query'
    fill_in  'Description', with: 'Description about this query'

    click_on 'Save'
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

    create_test_query

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

  if defined?(ActiveJob)
    context "async_execution feature is ON" do
      around do |ex|
        current_async_execution = Adhoq.config.async_execution
        current_active_job_queue_adapter = Adhoq::Engine.config.active_job.queue_adapter

        Adhoq.config.async_execution = true
        Adhoq::Engine.config.active_job.queue_adapter = :test
        Adhoq::ExecuteJob.queue_adapter.perform_enqueued_jobs = true

        ex.call

        Adhoq.config.async_execution = current_async_execution
        Adhoq::Engine.config.active_job.queue_adapter = current_active_job_queue_adapter
      end

      scenario 'Visit root, input query and generate report then we get a report' do
        visit '/adhoq'

        create_test_query

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
    end

    context "async_execution feature is OFF" do
      around do |ex|
        current_async_execution = Adhoq.config.async_execution
        current_active_job_queue_adapter = Adhoq::Engine.config.active_job.queue_adapter

        Adhoq.config.async_execution = false
        Adhoq::Engine.config.active_job.queue_adapter = :test
        Adhoq::ExecuteJob.queue_adapter.perform_enqueued_jobs = true

        ex.call

        Adhoq.config.async_execution = current_async_execution
        Adhoq::Engine.config.active_job.queue_adapter = current_active_job_queue_adapter
      end

      scenario 'Visit root, input query and generate report then we get a report' do
        visit '/adhoq'

        create_test_query

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
