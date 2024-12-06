defmodule Day01 do
  def part1(input) do
    lines = String.split(input, "\n", trim: true)

    {list1, list2} =
      Enum.map(
        lines,
        fn line ->
          [first, last] = String.split(line) |> Enum.map(&String.to_integer/1)
          {first, last}
        end
      )
      |> Enum.unzip()

    sorted1 = Enum.sort(list1)
    sorted2 = Enum.sort(list2)

    Enum.zip(sorted1, sorted2) |> Enum.map(fn {a, b} -> abs(a - b) end) |> Enum.sum()
  end

  def part2(input) do
    lines = String.split(input, "\n", trim: true)

    {list1, list2} =
      Enum.map(
        lines,
        fn line ->
          [first, last] = String.split(line) |> Enum.map(&String.to_integer/1)
          {first, last}
        end
      )
      |> Enum.unzip()

    sorted1 = Enum.sort(list1)
    sorted2 = Enum.sort(list2)

    Enum.reduce(sorted1, 0, fn element, simScore ->
      counts =
        Enum.reduce(sorted2, 0, fn el, count ->
          if el == element do
            count + 1
          else
            count
          end
        end)

      score = counts * element + simScore
      score
    end)
  end
end
