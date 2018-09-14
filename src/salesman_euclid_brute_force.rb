#!/usr/bin/env ruby

class Points
  def initialize
    @coordinates = []
  end

  def add(x, y)
    raise TypeError unless x.is_a?(Float) && y.is_a?(Float)
    raise 'less than zero' unless x >= 0 && y >= 0
    coordinate = [x, y].freeze
    raise 'already exist' if @coordinates.include? coordinate
    @coordinates << coordinate
  end

  def [](index)
    @coordinates[index] or raise 'invalid index'
  end

  def count
    @coordinates.count
  end
end

$points = Points.new

Integer($stdin.gets).times do
  $points.add(*$stdin.gets.split.map(&method(:Float)))
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
