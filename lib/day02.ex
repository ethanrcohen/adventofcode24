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

  # base cases:  empty list
  defp do_part2([], {last, numSkips, increasing}), do: {last, numSkips, increasing}

  defp do_part2([_head | _tail], {last, numSkips, increasing}) when numSkips > 1,
    do: {last, 2, increasing}

  # 1st element
  defp do_part2([firstElement | tail], {nil, numSkips, :unknown}) do
    {_, numSkipsSkippingFirst, _} = skippingFirst = do_part2(tail, {nil, numSkips + 1, :unknown})

    {_, numSkipsKeepingFirst, _} =
      keepingFirst = do_part2(tail, {firstElement, numSkips, :unknown})

    cond do
      numSkipsSkippingFirst <= 1 -> skippingFirst
      numSkipsKeepingFirst <= 1 -> keepingFirst
      true -> {nil, false, :unknown}
    end
  end

  # more than 1 or 3, try to skip
  defp do_part2([head | tail], {last, numSkips, increasing})
       when abs(head - last) > 3 or abs(head - last) < 1 do
    {_, numSkipsSkipping, _} = skipping = do_part2(tail, {last, numSkips + 1, increasing})

    cond do
      numSkipsSkipping <= 1 -> skipping
      true -> {last, false, increasing}
    end
  end

  # 2nd element, first time we can set increasing/decreasing
  defp do_part2([secondElement | tail], {firstElement, numSkips, :unknown}) do
    isIncreasing =
      case secondElement do
        secondElement when secondElement > firstElement -> :increasing
        _ -> :decreasing
      end

    {_, numSkipsSkippingSecond, _} =
      skippingSecond = do_part2(tail, {firstElement, numSkips + 1, :unknown})

    {_, numSkipsKeepingSecond, _} =
      keepingSecond = do_part2(tail, {secondElement, numSkips, isIncreasing})

    cond do
      numSkipsSkippingSecond <= 1 -> skippingSecond
      numSkipsKeepingSecond <= 1 -> keepingSecond
      true -> {firstElement, false, isIncreasing}
    end
  end

  # violating the always increasing
  defp do_part2([head | tail], {last, numSkips, :increasing}) when head <= last do
    {_, numSkipsSkipping, _} = skipping = do_part2(tail, {last, numSkips + 1, :increasing})

    cond do
      numSkipsSkipping <= 1 -> skipping
      true -> {last, false, :increasing}
    end
  end

  # violating always decreasing
  defp do_part2([head | tail], {last, numSkips, :decreasing}) when head >= last do
    {_, numSkipsSkipping, _} = skipping = do_part2(tail, {last, numSkips + 1, :decreasing})

    cond do
      numSkipsSkipping <= 1 -> skipping
      true -> {last, false, :decreasing}
    end
  end

  defp do_part2([head | tail], {last, numSkips, isIncreasing}) do
    {_, numSkipsSkippingHead, _} =
      skippingHead = do_part2(tail, {last, numSkips + 1, isIncreasing})

    {_, numSkipsKeepingHead, _} = keepingHead = do_part2(tail, {head, numSkips, isIncreasing})

    cond do
      numSkipsKeepingHead <= 1 -> keepingHead
      numSkipsSkippingHead <= 1 -> skippingHead
      true -> {last, false, isIncreasing}
    end
  end

  @spec part2(binary()) :: any()
  def part2(input) do
    lines = String.split(input, "\n", trim: true)

    Enum.reduce(
      lines,
      0,
      fn line, acc ->
        parsed = String.split(line) |> Enum.map(&String.to_integer/1)

        {_, numSkips, _} = do_part2(parsed, {nil, 0, :unknown})

        if numSkips < 2 do
          acc + 1
        else
          acc
        end
      end
    )
  end
end
