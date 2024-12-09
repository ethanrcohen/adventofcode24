defmodule Day03 do
  @mulregex ~r/mul\((\d{1,3}),(\d{1,3})\)/

  @spec part1(binary()) :: number()
  def part1(input) do
    lines = String.split(input, "\n", trim: true)

    Enum.reduce(
      lines,
      0,
      fn line, sum ->
        matches = Regex.scan(@mulregex, line, include_captures: true)

        sum +
          Enum.reduce(matches, 0, fn [_, x, y], acc ->
            acc + String.to_integer(x) * String.to_integer(y)
          end)
      end
    )
  end

  @spec part2(binary()) :: number()
  def part2(input) do
  end
end
