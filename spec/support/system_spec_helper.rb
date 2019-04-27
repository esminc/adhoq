module SystemSpecHelper
  def table_contant(table)
    first(table).all('tr').map {|row| row.all('th, td').map(&:text) }
  end
end
