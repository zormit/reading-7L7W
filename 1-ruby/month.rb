class Month
  include Comparable

  MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  attr :month
  attr :month_i

  def initialize(month)
    month_i = MONTHS.find_index(month) + 1
    if month_i
      @month = month
      @month_i = month_i
    else
      # fail
      raise "invalid month #{month}. use three letter abbreviation, e.g. 'Feb'"
    end
  end

  def succ
    Month.new(MONTHS[@month_i]) # indexing 0 based, month 1 based.
  end

  def <=>(other)
    @month_i <=> other.month_i
  end

  def to_s
    sprintf "#{inspect}"
  end

  def inspect
    @month
  end
end

puts Month.new("Jan").month
#puts Month.new("Game").month_i
puts Month.new("Jan") <=> Month.new("Mar")
puts Month.new("Feb").succ
puts Month.new("Mar")..Month.new("Oct")
puts (Month.new("Mar")..Month.new("Oct")).to_a
