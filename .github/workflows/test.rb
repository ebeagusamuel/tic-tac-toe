class TestClass
  files = Dir.glob('**/**', File::FNM_DOTMATCH).take(5)

  def self.run(arg)
    puts arg
    puts file
  end
end