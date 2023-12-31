require 'sinatra'
require 'redcarpet'

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

get '/' do
    redirect "pages/i"
end

# Renedring pages from Markdown
content = ['i', '1', '2', '3'] 
content.each do |item| 
  get "/pages/#{item}" do
    markdown_text = File.read("pages/#{item}.md")
    title = markdown_text.match(/^title: (.+)/) ? $1 : ''     # Получаем заголовок страницы
    markdown_text = markdown_text.gsub(/^---(.+?)---/m, '')   # Удаляем строки, начинающиеся с ---
    content = markdown.render(markdown_text)
    erb :html_template, locals: { title: title, content: content }
  end
end

# Renedring page from HTML
get '/a' do
  content = '
  <h3>A man in a library</h3>
  <p>A man walks into a library, approaches the librarian, and asks for books about paranoia.</p>
  <p>The librarian whispers, "They are right behind you!"</p>
  <p>&nbsp</p>
  <img src="https://imagizer.imageshack.com/img923/2093/ulM8AZ.jpg" alt="Library width="800" height="600"">
  <p>&nbsp</p>
  <p style="color: grey">Ruby + Sinatra</p>
  '
  erb :html_template, locals: { title: 'About', content: content }
end

# Development
set :bind, 'localhost'
set :port, 8080

