defmodule Day01Test do
  use ExUnit.Case
  alias Day01

  @example_input "3   4\n4   3\n2   5\n1   3\n3   9\n3   3"

  test "part1" do
    assert Day01.part1(@example_input) == 11
  end

  test "part2" do
    assert Day01.part2(@example_input) == 31
  end
end
