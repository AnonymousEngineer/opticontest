#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../src/ruby/salesman_euclid'

include Optimization::SalesmanEuclid::Common

points = Points.new

File.open ARGV[0] do |f|
  Integer(f.gets).times do
    points.add(*f.gets.split.map(&method(:Float)))
  end
end

solution = Solution.new points, $stdin.gets.split.map(&method(:Integer))

puts solution.length
