require 'fileutils'
require 'date'

dt_list = []

month_map = {'Jan'=>1,'Feb'=>2,'Mar'=>3,'Apr'=>4,'May'=>5,'Jun'=>6,'Jul'=>7,'Aug'=>8,'Sep'=>9,'Oct'=>10,'Nov'=>11,'Dec'=>12}

# Parse datetime in eml files
Dir.glob("./data/*.eml") do |file|
  File.open(file) do |f|
    while line = f.gets
      if /^Date: (.*)/ =~ line
        ary = $1.split(' ')
        time = ary[4].split ':'
        dt = DateTime.new(ary[3].to_i,month_map[ary[2]].to_i,ary[1].to_i,ary[4].to_i,time[0].to_i,time[1].to_i,time[2].to_i)
        dt_list << dt
        break
      end
    end
  end
end

#dt_list.sort.each do |d|
#  p d.to_s
#end

# Filter 2013 year
dt_2013 = []
dt_list.sort.each do |d|
  dt_2013 << d if d.year == 2013
end

puts "total: #{dt_2013}.size"
# dump
dt_2013.each do |d|
  #puts "#{d.year}/#{d.month}/#{d.day} #{d.hour}:#{d.min}:#{d.sec}"
end

# summary hourly base
h_summary = {}
dt_2013.each do |d|
  if not h_summary.key? d.hour
    h_summary[d.hour] = 1
  else
    h_summary[d.hour] += 1
  end
end

sum = 0
h_summary.sort.each do |k,v|
  puts "#{k}: #{v}"
  sum += v
end

__END__
todo: modulize summary logic
      output tsv
      output ltsv
      output csv
      output json
      
