#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ruby/salesman_euclid/common'
require_relative 'ruby/salesman_euclid/brute_force'

points = Optimization::SalesmanEuclid::Common::Points.new

Integer($stdin.gets).times do
  points.add(*$stdin.gets.split.map(&method(:Float)))
end

algorithm = Optimization::SalesmanEuclid::BruteForce::Algorithm.new points

solution = algorithm.solve

puts solution.indices.join ' '
