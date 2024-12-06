defmodule Day02 do
  def part1(input) do
    lines = String.split(input, "\n", trim: true)

    Enum.reduce(
      lines,
      0,
      fn line, acc ->
        {_, safe, _} =
          Enum.reduce(
            String.split(line) |> Enum.map(&String.to_integer/1),
            {-1, true, :unknown},
            fn el, {last, safeSoFar, increasing} ->
              cond do
                # not safe is a terminal condition
                not safeSoFar ->
                  {el, safeSoFar, increasing}

                last == -1 ->
                  {el, true, :unknown}

                el == last ->
                  {el, false, increasing}

                el > last and increasing == :decreasing ->
                  {el, false, increasing}

                el < last and increasing == :increasing ->
                  {el, false, increasing}

                abs(el - last) < 1 or abs(el - last) > 3 ->
                  {el, false, increasing}

                true ->
                  isIncreasing =
                    case el do
                      el when el > last -> :increasing
                      _ -> :decreasing
                    end

                  {el, true, isIncreasing}
              end
            end
          )

        if safe do
          acc + 1
        else
          acc
        end
      end
    )
  end

  def part2(input) do
  end
end
