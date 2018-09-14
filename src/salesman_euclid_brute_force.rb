#!/usr/bin/env ruby

$points = []

Integer($stdin.gets).times do
  $points << $stdin.gets.split.map(&method(:Integer))
end

$all_indices = (0...$points.count).to_a

$solutions = []

def len(indices)
  result = 0.0

  (indices.count - 1).times do |index|
    prev_point = $points[indices[index]]
    cur_point  = $points[indices[index + 1]]

    delta_x = prev_point[0] - cur_point[0]
    delta_y = prev_point[1] - cur_point[1]

    result += Math.sqrt delta_x**2 + delta_y**2
  end

  result
end

def rec(indices)
  return $solutions << [len(indices), indices] if indices.count == $points.count

  ($all_indices - indices).each do |index|
    rec indices + [index]
  end
end

rec []

$solutions.sort_by!(&:first)

puts $solutions.first.last.join ' '
