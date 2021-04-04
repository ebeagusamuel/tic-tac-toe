# require 'faraday'
# require 'json'

class TestClass
  def self.run(pr_num, repo, token)
    # url = "https://api.github.com/repos/ebeagusamuel/tic-tac-toe/pulls/8/files"
    # response = Faraday.get(url, {"Accept" => "application/vnd.github.v3+json"})
    # puts JSON.parse(response.body)
    # puts arg
    puts pr_num
    puts repo
    puts token
  end
end
