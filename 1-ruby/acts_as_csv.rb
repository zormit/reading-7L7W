class ActsAsCsv
  def self.acts_as_csv

    define_method 'read' do
      file = File.new(self.class.to_s.downcase + '.txt')
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @result << CsvRow.new(row.chomp.split(', '), @headers)
      end
    end

    define_method "headers" do
      @headers
    end

    define_method "csv_contents" do
      @result
    end

    define_method 'initialize' do
      @result = []
      read
    end

    define_method 'each' do
      puts yield
      @result.each { |row| puts row.first }
    end
  end
end

class RubyCsv < ActsAsCsv
  acts_as_csv
end

=begin
class Array
  @@columns = ['one', 'two']
  def method_missing name, *args
    self[@@columns.find_index(name.to_s)]
  end
=end
#a = ["foo", "bar"]
#puts a.one

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

r = CsvRow.new(["friedrich", "haendel"], ["first", "last"])
puts r.first
# puts r.name

m.each {puts "freeak"}
m.each {|row| puts row.last}
