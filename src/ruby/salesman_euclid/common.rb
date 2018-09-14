# frozen_string_literal: true

module Opticontest
  module SalesmanEuclid
    module Common
      class Points
        def initialize
          @coordinates = []
        end

        def add(xxx, yyy)
          raise TypeError unless xxx.is_a?(Float) && yyy.is_a?(Float)
          raise 'less than zero' unless xxx >= 0 && yyy >= 0

          coordinate = [xxx, yyy].freeze

          raise 'already exist' if @coordinates.include? coordinate

          @coordinates << coordinate
        end

        def [](index)
          @coordinates[index] or raise 'invalid index'
        end

        def count
          @coordinates.count
        end

        def distance(index1, index2)
          prev_point = self[index1]
          cur_point  = self[index2]

          delta_x = prev_point[0] - cur_point[0]
          delta_y = prev_point[1] - cur_point[1]

          Math.sqrt delta_x**2 + delta_y**2
        end

        def path_length(indices)
          result = 0.0

          (indices.count - 1).times do |index|
            result += distance indices[index], indices[index + 1]
          end

          result
        end
      end

      class Solution
        attr_reader :points, :indices

        def initialize(points, indices)
          raise TypeError unless points.is_a?(Points) && indices.is_a?(Array)

          indices.freeze

          raise 'invalid count' unless points.count == indices.count

          @points = points
          @indices = indices
        end

        def length
          @length ||= points.path_length indices
        end
      end
    end
  end
end
