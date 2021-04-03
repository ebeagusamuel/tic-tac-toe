require 'faraday'
require 'json'

class TestClass
  def self.run
    url = "https://api.github.com/repos/ebeagusamuel/tic-tac-toe/pulls/8/files"
    response = Faraday.get(url, {"Accept" => "application/vnd.github.v3+json"})
    p JSON.parse(response.body)
  end
end

# TestClass.run('ebeagusamuel/tic-tac-toe', 8)