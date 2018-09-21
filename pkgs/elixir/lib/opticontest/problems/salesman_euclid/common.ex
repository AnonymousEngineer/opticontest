defmodule Opticontest.Problems.SalesmanEuclid.Solution do
  defstruct [:indices, :length]

  def build(points, indices) do
    %__MODULE__{indices: indices, length: path_length(points, indices)}
  end

  defp path_length(points, indices) do
    do_path_length(points, indices, length(indices) - 1, 0.0)
  end

  defp do_path_length(_, _, 0, result), do: result

  defp do_path_length(points, indices, index, result) do
    do_path_length(
      points,
      indices,
      index - 1,
      result + distance(
        Enum.at(points, Enum.at(indices, index)),
        Enum.at(points, Enum.at(indices, index - 1))
      )
    )
  end

  defp distance({x1, y1}, {x2, y2}) do
    :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))
  end
end
