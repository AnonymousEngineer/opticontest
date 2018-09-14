# frozen_string_literal: true

module Opticontest
  module SalesmanEuclid
    module BruteForce
      class Algorithm
        include Opticontest::SalesmanEuclid::Common

        attr_reader :points, :solution

        def initialize(points)
          raise TypeError unless points.is_a? Points

          @points = points
          @solution = nil
          rec []
        end

      private

        def rec(indices)
          return add_solution indices if indices.count == points.count

          ((0...points.count).to_a - indices).each do |index|
            rec indices + [index]
          end
        end

        def add_solution(indices)
          new_solution = Solution.new points, indices
          return unless @solution.nil? || new_solution.length < @solution.length

          @solution = new_solution
        end
      end
    end
  end
end
