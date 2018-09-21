#!/usr/bin/env ruby
# frozen_string_literal: true

lib = File.expand_path(File.join('..', 'lib'), __dir__).freeze
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib

require 'opticontest/problems/salesman_euclid/common'
require 'opticontest/problems/salesman_euclid/brute_force'

points = Opticontest::Problems::SalesmanEuclid::Common::Points.new

Integer($stdin.gets).times do
  points.add(*$stdin.gets.split.map(&method(:Float)))
end

algorithm =
  Opticontest::Problems::SalesmanEuclid::BruteForce::Algorithm.new points

puts algorithm.solution.indices.join ' '
