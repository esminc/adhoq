require 'rspec/matchers'
require 'simple_xlsx_reader'

RSpec::Matchers.define :have_values_in_xlsx_sheet do |expect_values|
  match do |data|
    @actual_values = extract_values(data)
    expect(@actual_values).to eq expect_values
  end


  failure_message do
    RSpec::Expectations.differ.diff_as_object(@actual_values, expect_values)
  end

  private

  def extract_values(data)
    Tempfile.open(%w[actual .xlsx], Dir.tmpdir, encoding: 'BINARY') do |f|
      f.write data
      f.flush

      sheet = SimpleXlsxReader::Document.new(f.path).sheets.first
      if Gem::Version.new(SimpleXlsxReader::VERSION) < Gem::Version.new('2.0')
        # simple_xlsx_reader 1.x: eager sheet.headers / sheet.data
        [sheet.headers, *sheet.data]
      else
        # simple_xlsx_reader 2.x+: rows is lazy; use #each (safe without slurp)
        all_rows = []
        sheet.rows.each { |row| all_rows << row }
        [all_rows.first, *all_rows[1..-1]]
      end
    end
  end
end
