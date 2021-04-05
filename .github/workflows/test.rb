require 'pathspec'
require 'faraday'
require 'json'

class TestClass
  attr_reader :pr_num, :repo, :token, :repo_files

  def initialize(pr_num, repo, token)
    @pr_num = pr_num
    @repo = repo
    @token = token
  end

  def run
    rules = retrieve_pr_files(pr_num, repo, token, 'modified')

    if rules.nil? || rules.none?
      puts 0
    else
      puts rules
    end
  end

  private

  def retrieve_pr_files(pr_num, repo, token, status)
    url = "https://api.github.com/repos/#{repo}/pulls/#{pr_num}/files"
    response = Faraday.get(
      url,
       {
         "Accept" => "application/vnd.github.v3+json",
         "Authorization" => "token #{token}"
        }
      )
    files = JSON.parse(response.body)
    
    files.select{|file| file['status'] == status}.map{|file| file['filename']}
  end
end
