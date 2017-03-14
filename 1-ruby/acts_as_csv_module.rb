module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        # @csv_contents << row.chomp.split(', ')
        @csv_contents << CsvRow.new(row.chomp.split(', '), @headers)
      end
    end

    def each
      @csv_contents.each {|row| yield row }
    end

    attr_accessor :headers, :csv_contents
    def initialize
      read
    end
  end
end

class RubyCsv  # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv
end

class CsvRow
  def method_missing name, *args
    index = @header.find_index(name.to_s)
    if index
      @content[index]
    else
      raise "method really missing. or rather: column '#{name}' not found"
    end
  end

  def initialize(content, header)
    @content = content
    @header = header
  end

  def inspect
    @content
  end
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
# puts m.each { puts "test" }
m.each { |row| puts row.first }
