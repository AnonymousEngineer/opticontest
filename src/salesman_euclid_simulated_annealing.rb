#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ruby/salesman_euclid/common'
require_relative 'ruby/salesman_euclid/simulated_annealing'

require 'yaml'

points = Optimization::SalesmanEuclid::Common::Points.new

Integer($stdin.gets).times do
  points.add(*$stdin.gets.split.map(&method(:Float)))
end

config = Optimization::SalesmanEuclid::SimulatedAnnealing::Config.new(
  **YAML.load_file(
    File.expand_path(
      '../config/salesman_euclid_simulated_annealing.yml',
      __dir__,
    ),
  ),
)

algorithm = Optimization::SalesmanEuclid::SimulatedAnnealing::Algorithm.new(
  config,
  points,
)

solution = algorithm.solve

puts solution.indices.join ' '
