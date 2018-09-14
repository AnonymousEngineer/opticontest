#!/usr/bin/env ruby
# frozen_string_literal: true

points = []

File.open ARGV[0] do |f|
  Integer(f.gets).times do
    points << f.gets.split.map(&method(:Integer))
  end
end

indices = $stdin.gets.split.map(&method(:Integer))

raise 'Invalid count of indices' if points.size != indices.size

result = 0.0

(indices.count - 1).times do |index|
  prev_point = points[indices[index]]
  cur_point  = points[indices[index + 1]]

  delta_x = prev_point[0] - cur_point[0]
  delta_y = prev_point[1] - cur_point[1]

  result += Math.sqrt delta_x**2 + delta_y**2
end

puts result
