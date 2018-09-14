#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/salesman_euclid'

MAX_ITERATIONS = 2_000
MAX_TEMP = 100_000.0
TEMP_CHANGE = 0.98

class Config
  attr_reader :max_iterations, :max_temperature, :temperature_change

  def initialize(max_iterations:, max_temperature:, temperature_change:)
    self.max_iterations = max_iterations
    self.max_temperature = max_temperature
    self.temperature_change = temperature_change
  end

  def max_iterations=(value)
    raise TypeError unless value.is_a? Integer
    raise unless value.positive?

    @max_iterations = value
  end

  def max_temperature=(value)
    raise TypeError unless value.is_a? Float
    raise unless value.positive?

    @max_temperature = value
  end

  def temperature_change=(value)
    raise TypeError unless value.is_a? Float
    raise unless value.positive? && value < 1.0

    @temperature_change = value
  end
end

def search(points, config)
  current_solution = Solution.new points, random_permutation(points)
  temp = config.max_temperature
  best_solution = current_solution

  config.max_iterations.times do
    candidate_solution = create_neighbor current_solution
    temp *= config.temperature_change

    if should_accept? candidate_solution, current_solution, temp
      current_solution = candidate_solution
    end

    if candidate_solution.length < best_solution.length
      best_solution = candidate_solution
    end
  end

  best_solution
end

def random_permutation(points)
  perm = Array.new(points.count) { |i| i }
  perm.each_index do |i|
    r = rand(perm.size - i) + i
    perm[r], perm[i] = perm[i], perm[r]
  end
  perm
end

def should_accept?(candidate_solution, current_solution, temp)
  return true if candidate_solution.length <= current_solution.length

  rand < Math.exp((current_solution.length - candidate_solution.length) / temp)
end

def create_neighbor(current_solution)
  indices = Array.new current_solution.indices
  stochastic_two_opt! indices
  Solution.new current_solution.points, indices
end

def stochastic_two_opt!(perm)
  c1 = rand perm.size
  c2 = rand perm.size
  exclude = [c1]
  exclude << c1.zero? ? perm.size - 1 : c1 - 1
  exclude << (c1 == perm.size - 1) ? 0 : c1 + 1
  c2 = rand perm.size while exclude.include? c2
  c1, c2 = c2, c1 if c2 < c1
  perm[c1...c2] = perm[c1...c2].reverse
  perm
end

$points = Points.new

Integer($stdin.gets).times do
  $points.add(*$stdin.gets.split.map(&method(:Float)))
end

config = Config.new(
  max_iterations: MAX_ITERATIONS,
  max_temperature: MAX_TEMP,
  temperature_change: TEMP_CHANGE,
)

solution = search $points, config

puts solution.indices.join ' '
