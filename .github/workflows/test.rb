require 'pathspec'

class TestClass
  REPO_FILES = Dir.glob('**/**', File::FNM_DOTMATCH)

  def run
    rules = rules_matching_zero_files

    if rules.none?
      puts 'Rules array is empty'
      return
    end
    
    puts 'You have some rules in codeowners not matching any file in platform'; exit 1
  end

  private

  def rules_matching_zero_files
    modified = modified_files
    removed = removed_files

    if modified.split("\n").include?('.github/CODEOWNERS') && removed.split("\n").none?
      parsed_codeowners = parse_codeowners(lines_added_to_codeowners)

      parsed_codeowners.keys.each_with_object([]) do |rule, result|
        result << rule unless REPO_FILES.any?{|file| match?(rule, file)}
      end
    elsif removed.split("\n").any?
      codeowners = File.read('.github/CODEOWNERS').split("\n")
      parsed_codeowners = parse_codeowners(codeowners)

      rules_matching_removed_files = parsed_codeowners.keys.each_with_object([]) do |rule, result|
        result << rule if removed.split("\n").any?{|file| match?(rule, file)}
      end

      rules_matching_removed_files.each_with_object([]) do |rule, result|
        result << rule unless REPO_FILES.any?{|file| match?(rule, file)}
      end
    else
      []
    end
  end

  def most_recent_commit
    `/usr/bin/git log -n 1 --pretty=format:"%H" | tail -1`
  end

  def preceeding_commit
    `/usr/bin/git log -n 2 --pretty=format:"%H" | tail -1`
  end

  def modified_files
    `/usr/bin/git diff --name-only --diff-filter=M #{most_recent_commit} #{preceeding_commit}`
  end

  def removed_files
    `/usr/bin/git diff --name-only --diff-filter=D #{most_recent_commit} #{preceeding_commit}`
  end

  def lines_added_to_codeowners
    diff = `/usr/bin/git diff #{preceeding_commit} #{most_recent_commit} -- ./.github/CODEOWNERS`

    diff.split("\n").select{|line| line[0] == '+' && line[1] != '+'}.map{|line| line[1..-1]}
  end

  def parse_codeowners(codeowners)
    codeowners.each_with_object({}) do |line, h|
      next if line[0] == '#' || line.empty?
      pattern, *teams = line.gsub(/\s+/, ' ').strip.split(' ')
      h[pattern] = teams
    end
  end

  def match?(pattern, dir)
    pathspec_pattern = PathSpec.new(pattern)
    pathspec_pattern.match(dir)
  end
end
