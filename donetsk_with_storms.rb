require 'date'
# dictionary storms
storms = {}
File.open("donetsk_storms.csv", "r").each_line do |line|
  s = line.split(';')
  t = s[1].to_i < 10 ? '0'+s[1] : s[1]
  # key = "#{s[0]} #{t}:00:00"
  storms["#{s[0]} #{t}:00:00"] = s[2][0,2]
  # storms.store(key, s[2][0,2])
end
# puts "i=>#{storms.first.key}"
out_file = File.open("donetsk_17_21_with_storms.csv", "w")
# out_file.puts 'started_at;cloud_amount;wind_direction;wind_speed;temperature;temperature_dew;pressure;pressure_tendency;pressure_tendency_value;storm'
codes = ['00', '11', '30', '40', '50', '51', '52', '90', '91']
other = codes.size.to_s+'='
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
    code = storms[s[-2]].nil? ? '00' : storms[s[-2]] 
    w +=  codes.include?(code) ? codes.find_index(code).to_s : other # code
    out_file.puts w
  end

end