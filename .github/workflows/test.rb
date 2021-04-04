require 'faraday'
require 'json'

class TestClass
  def self.run(arg)
    url = "https://api.github.com/repos/ebeagusamuel/tic-tac-toe/pulls/8/files"
    response = Faraday.get(url, {"Accept" => "application/vnd.github.v3+json"})
    puts JSON.parse(response.body)
    puts arg
  end
end
