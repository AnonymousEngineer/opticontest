defmodule Opticontest.Problems.SalesmanEuclid.BruteForce do
  alias Opticontest.Problems.SalesmanEuclid.BruteForce.Solution

  def solve(points) when length(points) > 0 do
    permutate(points, Enum.to_list(0..(length(points) - 1)))
  end

  defp permutate(points, list) do
    do_permutate(points, list, [], nil)
  end

  defp do_permutate(points, [], perm, acc) do
    solution = Solution.build(points, perm)
    if is_nil(acc) || solution.length < acc.length, do: solution, else: acc
  end

  defp do_permutate(points, list, perm, acc) do
    list
    |> Stream.unfold(fn [h | t] -> {{h, t}, t ++ [h]} end)
    |> Enum.take(Enum.count(list))
    |> Enum.reduce(acc, fn {h, t}, acc ->
      do_permutate(points, t, [h | perm], acc)
    end)
  end
end

defmodule Opticontest.Problems.SalesmanEuclid.BruteForce.Solution do
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
