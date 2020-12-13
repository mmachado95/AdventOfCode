defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  def report_repair do
    read_file("input.txt")
    |> second(2020)
    |> Enum.reduce(&(&1*&2))
  end

  defp first([head | tail], sum) do
    if Enum.member?(tail, sum-head) do
      [head, sum-head]
    else
      first(tail, sum)
    end
  end
  defp first([], _), do: nil

  defp second([head | tail], sum) do
    two_entries = first(tail, sum-head)

    if two_entries do
      [head | two_entries]
    else
      second(tail, sum)
    end
  end

  defp read_file(path) do
    path
    |> File.read!
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
