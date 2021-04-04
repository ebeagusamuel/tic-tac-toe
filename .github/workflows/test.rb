# # require 'faraday'
# require 'json'

# class TestClass
#   def self.run(pr_num, repo, token)
#     # url = "https://api.github.com/repos/ebeagusamuel/tic-tac-toe/pulls/8/files"
#     # response = Faraday.get(url, {"Accept" => "application/vnd.github.v3+json"})
#     # JSON.parse(response.body)
#     # puts arg
#     puts pr_num
#     puts repo
#     puts token
#   end
# end

require 'pathspec'
require 'faraday'
require 'json'

class RulesMatchingZeroFiles
  attr_reader :pr_num, :repo, :token, :repo_files

  def initialize(pr_num, repo, token)
    @pr_num = pr_num
    @repo = repo
    @token = token
    @repo_files = Dir.glob('**/**', File::FNM_DOTMATCH)
  end

  def run
    rules = rules_matching_zero_files(pr_num, repo, token)

    return if rules.nil? || rules.none?

    rules
  end

  private

  def rules_matching_zero_files(pr_num, repo, token)
    modified = retrieve_pr_files(pr_num, repo, token, 'modified')
    removed = retrieve_pr_files(pr_num, repo, token, 'removed')
    
    if modified.include?('.github/CODEOWNERS')
      parse_codeowners.keys.each_with_object([]) do |rule, result|
        result << rule unless repo.any? {|file| match?(rule, file)}
      end
    elsif removed.any?
      rules_matching_removed_files = parse_codeowners.keys.each_with_object([]) do |rule, result|
        result << rule if removed.any?{|file| match?(rule, file)}
      end

      rules_matching_removed_files.each_with_object([]) do |rule, result|
        result << rule unless repo.any?{|file| match?(rule, file)}
      end
    end
  end

  def parse_codeowners
    h = {}
    codeowners = File.read('.github/CODEOWNERS')
    codeowners.split("\n").each do |line|
      next if line[0] == '#'
      parts = line.gsub(/\s+/, ' ').strip.split(' ')
      pattern = parts[0]
      teams = parts.drop(1).to_a
      h[pattern] = teams if pattern
    end
    h
  end

  def match?(pattern, dir)
    pathspec_pattern = PathSpec.new(pattern)
    pathspec_pattern.match(dir)
  end

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
    
    files.select{|file| file[:status] == status}.map{|file| file[:filename]}
  end
end

puts RulesMatchingZeroFiles.new(9, 'ebeagusamuel/tic-tac-toe', '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').run