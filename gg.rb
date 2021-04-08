require 'faraday'
require 'json'

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
  # puts files
  
  files.select{|file| file['status'] == status}.map{|file| file['filename']}
end
