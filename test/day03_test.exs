defmodule Day03Test do
  use ExUnit.Case
  alias Day03

  @example_input "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

  test "part1" do
    assert Day03.part1(@example_input) == 161
  end

  test "part2" do
    assert Day03.part2(@example_input) == 4
  end
end
