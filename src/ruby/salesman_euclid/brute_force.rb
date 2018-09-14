# frozen_string_literal: true

module Optimization
  module SalesmanEuclid
    module BruteForce
      class Algorithm
        include Optimization::SalesmanEuclid::Common

        attr_reader :points

        def initialize(points)
          raise TypeError unless points.is_a? Points

          @points = points
        end

        def solve
          solutions = []
          rec solutions, []
          solutions.sort_by!(&:length)
          solutions.first
        end

      private

        def rec(solutions, indices)
          if indices.count == points.count
            solutions << Solution.new(points, indices)
            return
          end

          ((0...points.count).to_a - indices).each do |index|
            rec solutions, indices + [index]
          end
        end
      end
    end
  end
end
