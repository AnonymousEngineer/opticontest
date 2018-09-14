#!/usr/bin/env ruby
# frozen_string_literal: true

lib = File.expand_path(File.join('..', 'pkgs', 'ruby', 'lib'), __dir__).freeze
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib

require 'opticontest/salesman_euclid/common'
require 'opticontest/salesman_euclid/brute_force'

points = Opticontest::SalesmanEuclid::Common::Points.new

Integer($stdin.gets).times do
  points.add(*$stdin.gets.split.map(&method(:Float)))
end

algorithm = Opticontest::SalesmanEuclid::BruteForce::Algorithm.new points

puts algorithm.solution.indices.join ' '
