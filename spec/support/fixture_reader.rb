module Support
  module FixtureReader
    def fixture(path)
      IO.read("#{File.dirname(__FILE__)}/../fixtures/#{path}")
    end
  end
end
