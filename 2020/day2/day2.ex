defmodule Day2 do

  def main do
    read_file("input.txt")
    |> Enum.map(&set_password_policy/1)
    |> Enum.count(&second_password_is_valid/1)
    |> IO.puts
  end


  defp read_file(path) do
    path
    |> File.read!
    |> String.split("\n")
  end

  defp set_password_policy(line) do
    [_, min, max, letter, password] = Regex.run(~r/(\d+)-(\d+) ([a-z]+): ([a-z]+)/, line)

    [String.to_integer(min), String.to_integer(max), letter, password]
  end

  defp first_password_is_valid([min, max, letter, password]) do
    occurrences = password |> String.graphemes |> Enum.count(& &1 == letter)

    occurrences >= min && occurrences <= max
  end

  defp second_password_is_valid([min, max, letter, password]) do
    String.at(password, min-1) == letter && String.at(password, max-1) != letter ||
      String.at(password, min-1) != letter && String.at(password, max-1) == letter
  end
end
