require 'date'
# dictionary storms
visibility = {}
File.open("donetsk_visibility.csv", "r").each_line do |line|
  # 2017-09-08 12:18:13;ЩЭОЯЮ WAREP 34519 0812161 40 72081//=
  s = line.split(';')
  h = s[1][20,2].to_i/3*3
  t = h<10 ? '0'+h.to_s : h.to_s
  # key = "#{s[0]} #{t}:00:00"
  visibility["#{s[0][0,10]} #{t}:00:00"] = s[1]
  # storms.store(key, s[2][0,2])
end
puts "i=>#{visibility.size}"
out_file = File.open("donetsk_17_21_visibility.csv", "w")
# out_file.puts 'started_at;cloud_amount;wind_direction;wind_speed;temperature;temperature_dew;pressure;pressure_tendency;pressure_tendency_value;storm'
File.open("donetsk_16_21_with_max_temp.csv", "r").each_line do |line|
  # 2016-01-01;0;9;7; 4;5;2;-14.3;-15.6;999.7;7;0.5;2016-01-01 00:00:00; -11.5
  w = ''
  if line[0,10] > '2017-08-31'
    s = line.split(';')
    
    w = s[-2]+';' # started_at
    w += s[2]+';' # cloud_height
    w += s[4]+';' # cloud_amount
    w += s[5]+';' # wind_direction
    w += s[6]+';' # wind_speed
    w += s[7]+';' # temperature
    w += s[8]+';' # temperature_dew
    w += s[9]+';' # pressure
    w += s[10]+';' # pressure_tendency
    w += s[11]+';' # pressure_tendency_value
    w += visibility[s[-2]].nil? ? '0' : '1'
    out_file.puts w
  end

end