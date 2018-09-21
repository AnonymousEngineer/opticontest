# frozen_string_literal: true

module Opticontest
  module Problems
    module SalesmanEuclid
      module RandomSearch
        class Config
          attr_reader :max_iterations

          def initialize(max_iterations:)
            self.max_iterations = max_iterations
          end

        private

          def max_iterations=(value)
            raise TypeError unless value.is_a? Integer
            raise unless value.positive?

            @max_iterations = value
          end
        end

        class Algorithm
          include Opticontest::Problems::SalesmanEuclid::Common

          attr_reader :config, :points, :solution

          def initialize(config, points)
            raise TypeError unless config.is_a?(Config) && points.is_a?(Points)

            @config = config
            @points = points

            @solution = solve
          end

        private

          def solve
            best_solution = Solution.random points

            config.max_iterations.times do
              current_solution = Solution.random points

              next unless current_solution.length < best_solution.length

              best_solution = current_solution
            end

            best_solution
          end
        end
      end
    end
  end
end
