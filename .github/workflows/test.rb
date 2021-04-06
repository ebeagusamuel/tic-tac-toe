require 'pathspec'
require 'faraday'
require 'json'

class TestClass
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
    
    puts 'Hello'; exit 1
  end

  private

  def rules_matching_zero_files(pr_num, repo, token)
    modified = retrieve_pr_files(pr_num, repo, token, 'added')
    removed = retrieve_pr_files(pr_num, repo, token, 'removed')
    parsed_codeowners = parse_codeowners

    if modified.include?('.github/CODEOWNERS')
      parsed_codeowners.keys.each_with_object([]) do |rule, result|
        result << rule unless repo_files.any?{|file| match?(rule, file)}
      end
    elsif removed.any?
      rules_matching_removed_files = parsed_codeowners.keys.each_with_object([]) do |rule, result|
        result << rule if removed.any?{|file| match?(rule, file)}
      end

      rules_matching_removed_files.each_with_object([]) do |rule, result|
        result << rule unless repo_files.any?{|file| match?(rule, file)}
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
    response = Faraday.new(
      url,
      headers: { 
      "Accept" => "application/vnd.github.v3+json",
      "Authorization" => "token #{token}"
      }
    ).get        
    files = JSON.parse(response.body)
    
    files.select{|file| file['status'] == status}.map{|file| file['filename']}
  end
end

# RulesMatchingZeroFiles.new(1, 'ebeagusamuel/samAndKayode', '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').run