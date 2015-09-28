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
      [sheet.headers, *sheet.data]
    end
  end
end
