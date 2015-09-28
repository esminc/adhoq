module Adhoq
  class Result
    attr_reader :header, :rows

    def initialize(header, rows = [])
      @header = header
      @rows   = rows
    end

    def <<(row)
      rows << row
    end

    def ==(obj)
      header == obj.header && rows == obj.rows
    end
  end
end
