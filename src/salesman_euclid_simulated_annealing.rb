#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/salesman_euclid'

MAX_ITERATIONS = 2_000
MAX_TEMP = 100_000.0
TEMP_CHANGE = 0.98

def search(points, max_iterations, max_temp, temp_change)
  current_solution = Solution.new points, random_permutation(points)
  temp = max_temp
  best_solution = current_solution

  max_iterations.times do
    candidate_solution = create_neighbor current_solution
    temp *= temp_change

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
    r = rand(perm.size-i) + i
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
  exclude << ((c1==0) ? perm.size-1 : c1-1)
  exclude << ((c1==perm.size-1) ? 0 : c1+1)
  c2 = rand(perm.size) while exclude.include?(c2)
  c1, c2 = c2, c1 if c2 < c1
  perm[c1...c2] = perm[c1...c2].reverse
  perm
end

$points = Points.new

Integer($stdin.gets).times do
  $points.add(*$stdin.gets.split.map(&method(:Float)))
end

solution = search $points, MAX_ITERATIONS, MAX_TEMP, TEMP_CHANGE

puts solution.indices.join ' '
