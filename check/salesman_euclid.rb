#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../pkgs/ruby/lib/opticontest/salesman_euclid/common'

points = Opticontest::SalesmanEuclid::Common::Points.new

File.open ARGV[0] do |f|
  Integer(f.gets).times do
    points.add(*f.gets.split.map(&method(:Float)))
  end
end

solution = Opticontest::SalesmanEuclid::Common::Solution.new(
  points,
  $stdin.gets.split.map(&method(:Integer)),
)

puts solution.length
