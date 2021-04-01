class TestClass
  FILES = Dir.glob('**/**', File::FNM_DOTMATCH).take(5)

  def self.run(arg)
    puts arg
    puts FILES
  end
end