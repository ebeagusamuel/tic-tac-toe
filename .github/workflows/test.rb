require_relative 'files_to_ignore'

class TestClass
  FILES = Dir.glob('**/**', File::FNM_DOTMATCH)

  def self.run(arg)
    puts arg
    puts FILES.size
    puts FILES - IGNORE_FILES
  end
end
