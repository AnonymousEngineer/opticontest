#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../pkgs/ruby/lib/opticontest/salesman_euclid/common'
require_relative '../pkgs/ruby/lib/opticontest/salesman_euclid/simulated_annealing'

require 'yaml'

points = Opticontest::SalesmanEuclid::Common::Points.new

Integer($stdin.gets).times do
  points.add(*$stdin.gets.split.map(&method(:Float)))
end

config = Opticontest::SalesmanEuclid::SimulatedAnnealing::Config.new(
  **YAML.load_file(
    File.expand_path(
      '../config/salesman_euclid_simulated_annealing.yml',
      __dir__,
    ),
  ),
)

algorithm = Opticontest::SalesmanEuclid::SimulatedAnnealing::Algorithm.new(
  config,
  points,
)

puts algorithm.solution.indices.join ' '
