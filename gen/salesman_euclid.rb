#!/usr/bin/env ruby
# frozen_string_literal: true

count = Integer ARGV[0]

points = []

count.times do
  points << [rand(0.0..count), rand(0.0..count)]
end

puts count

points.each do |point|
  puts point.join ' '
end
