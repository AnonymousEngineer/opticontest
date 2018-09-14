#!/usr/bin/env ruby

points = []

File.open ARGV[0] do |f|
  Integer(f.gets).times do
    points << f.gets.split.map(&method(:Integer))
  end
end

indices = $stdin.gets.split.map(&method(:Integer))

raise 'Invalid count of indices' if points.size != indices.size

result = 0.0

indices[1..-1].each do |index|
  prev_point = points[index - 1]
  cur_point  = points[index]

  delta_x = prev_point[0] - cur_point[0]
  delta_y = prev_point[1] - cur_point[1]

  result += Math.sqrt delta_x**2 + delta_y**2
end

puts result
