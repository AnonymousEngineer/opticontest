#!/usr/bin/env ruby
# frozen_string_literal: true

lib = File.expand_path(File.join('..', 'lib'), __dir__).freeze
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib

require 'opticontest/problems/salesman_euclid/common'
require 'opticontest/problems/salesman_euclid/random_search'

require 'yaml'

points = Opticontest::Problems::SalesmanEuclid::Common::Points.new

Integer($stdin.gets).times do
  points.add(*$stdin.gets.split.map(&method(:Float)))
end

config = Opticontest::Problems::SalesmanEuclid::RandomSearch::Config.new(
  **YAML.load_file(
    File.expand_path(
      '../../../config/salesman_euclid_random_search.yml',
      __dir__,
    ),
  ),
)

algorithm =
  Opticontest::Problems::SalesmanEuclid::RandomSearch::Algorithm.new(
    config,
    points,
  )

puts algorithm.solution.indices.join ' '
