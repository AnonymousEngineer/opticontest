# frozen_string_literal: true

module Opticontest
  module Problems
    module SalesmanEuclid
      module SimulatedAnnealing
        class Config
          attr_reader :max_iterations, :initial_temperature, :temperature_change

          def initialize(max_iterations:,
                         initial_temperature:, temperature_change:)
            self.max_iterations = max_iterations
            self.initial_temperature = initial_temperature
            self.temperature_change = temperature_change
          end

        private

          def max_iterations=(value)
            raise TypeError unless value.is_a? Integer
            raise unless value.positive?

            @max_iterations = value
          end

          def initial_temperature=(value)
            raise TypeError unless value.is_a? Float
            raise unless value.positive?

            @initial_temperature = value
          end

          def temperature_change=(value)
            raise TypeError unless value.is_a? Float
            raise unless value.positive? && value < 1.0

            @temperature_change = value
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
            current_solution = Solution.random points
            temp = config.initial_temperature
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

          def should_accept?(candidate_solution, current_solution, temp)
            return true if candidate_solution.length <= current_solution.length

            rand < Math.exp(
              (current_solution.length - candidate_solution.length) / temp,
            )
          end

          def create_neighbor(current_solution)
            indices = Array.new current_solution.indices
            stochastic_two_opt! indices
            Solution.new current_solution.points, indices
          end

          def stochastic_two_opt!(perm)
            c1 = rand perm.size
            c2 = rand perm.size
            c2 = rand perm.size while c1 == c2
            c1, c2 = c2, c1 if c2 < c1
            perm[c1..c2] = perm[c1..c2].reverse
            perm
          end
        end
      end
    end
  end
end
