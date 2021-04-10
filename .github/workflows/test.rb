require 'pathspec'

class TestClass
  class << self
    def get_info
      `git fetch origin master:master`
      new(
        repo_files,
        modified_files,
        removed_files,
        parse_codeowners,
      )
    end

    private

    def most_recent_commit
      `git log -n 1 --pretty=format:"%H" | tail -1`
    end
  
    def modified_files
      `git diff --name-only --diff-filter=M master #{most_recent_commit}`
    end
  
    def removed_files
      `git diff --name-only --diff-filter=D master #{most_recent_commit}`
    end
  
    def lines_added_to_codeowners
      diff = `git diff master #{most_recent_commit} -- .github/CODEOWNERS`
  
      diff.split("\n").select{|line| line[0] == '+' && line[1] != '+'}.map{|line| line[1..-1]}
    end

    def repo_files
      Dir.glob('**/**', File::FNM_DOTMATCH)
    end

    def parse_codeowners
      codeowners = removed_files.split("\n").any? ? File.read('.github/CODEOWNERS').split("\n") : lines_added_to_codeowners
      codeowners.each_with_object({}) do |line, h|
        next if line[0] == '#' || line.empty?
        pattern, *teams = line.gsub(/\s+/, ' ').strip.split(' ')
        h[pattern] = teams
      end
    end
  end

  attr_reader :repo_files, :modified_files, :removed_files, :codeowners

  def initialize(repo_files, modified_files, removed_files, codeowners)
    @repo_files = repo_files
    @modified_files = modified_files
    @removed_files = removed_files
    @codeowners = codeowners
  end

  def run
    rules = rules_matching_zero_files

    return if rules.none?
    
    puts 'You have some rules in codeowners not matching any file in platform'; exit 1 
  end

  private

  def rules_matching_zero_files
    if modified_files.split("\n").include?('.github/CODEOWNERS') && removed_files.split("\n").none?
      codeowners.keys.each_with_object([]) do |rule, result|
        result << rule unless repo_files.any?{|file| match?(rule, file)}
      end
    elsif removed_files.split("\n").any?
      rules_matching_removed_files = codeowners.keys.each_with_object([]) do |rule, result|
        result << rule if removed_files.split("\n").any?{|file| match?(rule, file)}
      end

      rules_matching_removed_files.each_with_object([]) do |rule, result|
        result << rule unless repo_files.any?{|file| match?(rule, file)}
      end
    else
      []
    end
  end

  def match?(pattern, dir)
    pathspec_pattern = PathSpec.new(pattern)
    pathspec_pattern.match(dir)
  end
end
