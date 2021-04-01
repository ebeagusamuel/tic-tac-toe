require_relative 'files_to_ignore'

class TestClass
  # FILES = Dir.glob('**/**', File::FNM_DOTMATCH)

  def self.run(arg)
    # a = arg.select{|entry| entry[:status] != 'removed'}.map{|e| e[:filename]}

    puts arg.class
  end
end
