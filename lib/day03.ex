defmodule Day03 do
  @mulregex ~r/mul\((\d{1,3}),(\d{1,3})\)/
  @p2regex ~r/(mul\((\d{1,3}),(\d{1,3})\))|(do\(\))|(don't\(\))/
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

  # do we need to handle do / don't across lines? let's assume so
  @spec part2(binary()) :: number()
  def part2(input) do
    matches = Regex.scan(@p2regex, input, include_captures: true)

    {out, _} =
      Enum.reduce(matches, {0, true}, fn [match, _, x, y | _], {sum, enabled} ->
        cond do
          match == "do()" ->
            {sum, true}

          match == "don't()" ->
            {sum, false}

          not enabled ->
            {sum, enabled}

          enabled ->
            {sum + String.to_integer(x) * String.to_integer(y), enabled}
        end
      end)

    out
  end
end
