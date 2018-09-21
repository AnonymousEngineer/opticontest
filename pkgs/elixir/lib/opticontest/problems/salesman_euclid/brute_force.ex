defmodule Opticontest.Problems.SalesmanEuclid.BruteForce do
  alias Opticontest.Problems.SalesmanEuclid.Solution

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
