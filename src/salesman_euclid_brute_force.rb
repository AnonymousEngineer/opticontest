#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ruby/salesman_euclid/common'

include Optimization::SalesmanEuclid::Common

$points = Points.new

Integer($stdin.gets).times do
  $points.add(*$stdin.gets.split.map(&method(:Float)))
end

$all_indices = (0...$points.count).to_a

$solutions = []

def rec(indices)
  if indices.count == $points.count
    $solutions << Solution.new($points, indices)
    return
  end

  ($all_indices - indices).each do |index|
    rec indices + [index]
  end
end

rec []

$solutions.sort_by!(&:length)

puts $solutions.first.indices.join ' '
