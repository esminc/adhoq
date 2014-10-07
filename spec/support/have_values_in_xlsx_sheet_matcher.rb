require 'rspec/matchers'
require 'simple_xlsx_reader'

RSpec::Matchers.define :have_values_in_xlsx_sheet do |values|
  match do |data|
    expect(extract_values(data)).to eq values
  end

  private

  def extract_values(data)
    Tempfile.open(%w[actual .xlsx], Dir.tmpdir, encoding: 'BINARY') do |f|
      f.write data.read
      f.flush

      sheet = SimpleXlsxReader::Document.new(f.path).sheets.first
      [sheet.headers, *sheet.data]
    end
  end
end
