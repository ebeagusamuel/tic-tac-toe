require 'pathspec'
require 'faraday'
require 'json'

class RulesMatchingZeroFiles
  attr_reader :pr_num, :repo, :repo_files

  def initialize(pr_num, repo)
    @pr_num = pr_num
    @repo = repo
    @repo_files = Dir.glob('**/**', File::FNM_DOTMATCH)
  end

  def run
    rules = rules_matching_zero_files(pr_num, repo)

    if rules.nil? || rules.none?
      puts 0
    else
      puts 1
    end
  end

  private

  def rules_matching_zero_files(pr_num, repo)
    modified = retrieve_pr_files(pr_num, repo, 'modified')
    removed = retrieve_pr_files(pr_num, repo, 'removed')
    parsed_codeowners = parse_codeowners

    if modified.include?('.github/CODEOWNERS')
      parsed_codeowners.keys.each_with_object([]) do |rule, result|
        result << rule unless repo_files.any?{|file| match?(rule, file)}
      end
    elsif removed.any?
      rules_matching_removed_files = parsed_codeowners.keys.each_with_object([]) do |rule, result|
        result << rule if removed.any?{|file| match?(rule, file)}
      end
      p rules_matching_removed_files
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
    p h
    h
  end

  def match?(pattern, dir)
    pathspec_pattern = PathSpec.new(pattern)
    pathspec_pattern.match(dir)
  end

  def retrieve_pr_files(pr_num, repo, status)
    url = "https://api.github.com/repos/#{repo}/pulls/#{pr_num}/files"
    response = Faraday.get(
      url,
       {
         "Accept" => "application/vnd.github.v3+json",
        }
      )
    files = JSON.parse(response.body)
    
    pp files.select{|file| file['status'] == status}.map{|file| file['filename']}

    files.select{|file| file['status'] == status}.map{|file| file['filename']}
  end
end

RulesMatchingZeroFiles.new(9, 'ebeagusamuel/tic-tac-toe').run