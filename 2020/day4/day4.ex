defmodule Day4 do
  @required_fields ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def part1 do
    parse_passports("input.txt") |> Enum.count(&required_fields?/1)
  end

  def part2 do
    parse_passports("input.txt") |> Enum.count(&valid?/1)
  end

  defp parse_passports(filename) do
    filename
    |> File.read!
    |> String.split(~r{\n\n}, trim: true)
    |> Enum.map(&String.replace(&1, ~r{\n}, " "))
    |> Enum.map(&String.split(&1, ~r{\s}))
    |> Enum.map(&parse_passport/1)
  end

  defp parse_passport(passport) do
    passport
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(&List.to_tuple/1)
    |> Enum.into(%{})
  end

  defp required_fields?(passport) do
    Enum.all?(@required_fields, &Map.has_key?(passport, &1))
  end

  defp valid?(passport) do
    Enum.all?(@required_fields, &valid?(&1, passport[&1]))
  end
  defp valid?(_, nil), do: false
  defp valid?("byr", value), do: 1920 <= String.to_integer(value) and  String.to_integer(value) <= 2002
  defp valid?("iyr", value), do: 2010 <= String.to_integer(value) and  String.to_integer(value) <= 2020
  defp valid?("eyr", value), do: 2020 <= String.to_integer(value) and  String.to_integer(value) <= 2030
  defp valid?("hcl", value), do: String.match?(value, ~r/^#[0-9a-f]{6}$/)
  defp valid?("ecl", value), do: Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], value)
  defp valid?("pid", value), do: String.match?(value, ~r/^\d{9}$/)
  defp valid?("hgt", value) do
    matches = Regex.run(~r{(\d+)(in|cm)}, value)

    with [_, value, unit] <- matches do
      case unit do
        "cm" -> 150 <= String.to_integer(value) and String.to_integer(value) <= 193
        "in" -> 59 <= String.to_integer(value) and String.to_integer(value) <= 76
        _ -> false
      end
    end
  end
end


Day4.part1() |> IO.inspect
Day4.part2() |> IO.inspect
