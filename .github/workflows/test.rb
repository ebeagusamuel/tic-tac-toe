require 'faraday'
require 'json'

class TestClass
  def self.run(pr_num)
    # url = "https://api.github.com/repos/#{repo}/pulls/#{pr_num}/files"
    # response = Faraday.get(url, {"Accept" => "application/vnd.github.v3+json"})
    # p JSON.parse(response.body).class
    puts pr_num
  end
end

# TestClass.run('ebeagusamuel/tic-tac-toe', 8)