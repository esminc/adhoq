require 'rouge'

module Adhoq::QueryDecorator
  def query_with_highlight
    formatter = Rouge::Formatters::HTML.new(css_class: 'highlight query')
    lexer = Rouge::Lexers::SQL.new
    formatter.format(lexer.lex(query))
  end
end
