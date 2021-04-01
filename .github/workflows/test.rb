class TestClass
  FILES = Dir.glob('**/**', File::FNM_DOTMATCH)

  def self.run(arg)
    puts arg
    puts FILES.size
    puts FILES
  end
end