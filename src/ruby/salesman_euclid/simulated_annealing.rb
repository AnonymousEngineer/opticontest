# frozen_string_literal: true

module Optimization
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
    end
  end
end
