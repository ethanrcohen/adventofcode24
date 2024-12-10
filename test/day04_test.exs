defmodule Day04Test do
  use ExUnit.Case
  alias Day04

  @example_input """
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """

  test "part1" do
    assert Day04.part1(@example_input) == 18
  end

  test "part2" do
    assert Day04.part2(@example_input) == 9
  end
end
