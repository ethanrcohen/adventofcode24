defmodule Day04 do
  @spec part1(binary()) :: number()
  def part1(input) do
    letters = parse(input)

    Enum.reduce(
      Tuple.to_list(letters) |> Enum.with_index(),
      0,
      fn {row, row_ind}, acc ->
        acc +
          Enum.reduce(
            Tuple.to_list(row) |> Enum.with_index(),
            0,
            fn {_letter, col_ind}, matches ->
              matches +
                word_search_from_letter(letters, "XMAS", {0, row_ind, col_ind, :right}) +
                word_search_from_letter(letters, "XMAS", {0, row_ind, col_ind, :left}) +
                word_search_from_letter(letters, "XMAS", {0, row_ind, col_ind, :down}) +
                word_search_from_letter(letters, "XMAS", {0, row_ind, col_ind, :up}) +
                word_search_from_letter(letters, "XMAS", {0, row_ind, col_ind, :diag_ltr_up}) +
                word_search_from_letter(letters, "XMAS", {0, row_ind, col_ind, :diag_ltr_down}) +
                word_search_from_letter(letters, "XMAS", {0, row_ind, col_ind, :diag_rtl_up}) +
                word_search_from_letter(letters, "XMAS", {0, row_ind, col_ind, :diag_rtl_down})
            end
          )
      end
    )
  end

  defp word_search_from_letter(
         board,
         goal_word,
         {goal_word_ind, board_ind_row, board_ind_col, direction}
       ) do
    cond do
      board_ind_row < 0 or board_ind_row >= tuple_size(board) ->
        0

      board_ind_col < 0 or board_ind_col >= tuple_size(elem(board, 0)) ->
        0

      elem(elem(board, board_ind_row), board_ind_col) != String.at(goal_word, goal_word_ind) ->
        0

      goal_word_ind == String.length(goal_word) - 1 ->
        1

      direction == :right ->
        word_search_from_letter(
          board,
          goal_word,
          {goal_word_ind + 1, board_ind_row, board_ind_col + 1, direction}
        )

      direction == :left ->
        word_search_from_letter(
          board,
          goal_word,
          {goal_word_ind + 1, board_ind_row, board_ind_col - 1, direction}
        )

      direction == :up ->
        word_search_from_letter(
          board,
          goal_word,
          {goal_word_ind + 1, board_ind_row - 1, board_ind_col, direction}
        )

      direction == :down ->
        word_search_from_letter(
          board,
          goal_word,
          {goal_word_ind + 1, board_ind_row + 1, board_ind_col, direction}
        )

      direction == :diag_ltr_up ->
        word_search_from_letter(
          board,
          goal_word,
          {goal_word_ind + 1, board_ind_row - 1, board_ind_col + 1, direction}
        )

      direction == :diag_ltr_down ->
        word_search_from_letter(
          board,
          goal_word,
          {goal_word_ind + 1, board_ind_row + 1, board_ind_col + 1, direction}
        )

      direction == :diag_rtl_up ->
        word_search_from_letter(
          board,
          goal_word,
          {goal_word_ind + 1, board_ind_row - 1, board_ind_col - 1, direction}
        )

      direction == :diag_rtl_down ->
        word_search_from_letter(
          board,
          goal_word,
          {goal_word_ind + 1, board_ind_row + 1, board_ind_col - 1, direction}
        )
    end
  end

  @spec part2(binary()) :: number()
  def part2(input) do
    letters = parse(input)

    Enum.reduce(
      Tuple.to_list(letters) |> Enum.with_index(),
      0,
      fn {row, row_ind}, acc ->
        acc +
          Enum.reduce(
            Tuple.to_list(row) |> Enum.with_index(),
            0,
            fn {letter, col_ind}, matches ->
              matches +
                cond do
                  # since forming X's, we need to be a full row/col away from the edges
                  row_ind < 1 or row_ind >= tuple_size(letters) - 1 ->
                    0

                  col_ind < 1 or col_ind >= tuple_size(elem(letters, 0)) - 1 ->
                    0

                  letter != "A" ->
                    0

                  true ->
                    top_right = elem(elem(letters, row_ind - 1), col_ind + 1)
                    bottom_left = elem(elem(letters, row_ind + 1), col_ind - 1)

                    ltr =
                      (top_right == "M" and bottom_left == "S") or
                        (bottom_left == "M" and top_right == "S")

                    top_left = elem(elem(letters, row_ind - 1), col_ind - 1)
                    bottom_right = elem(elem(letters, row_ind + 1), col_ind + 1)

                    rtl =
                      (top_left == "M" and bottom_right == "S") or
                        (bottom_right == "M" and top_left == "S")

                    if rtl and ltr do
                      1
                    else
                      0
                    end
                end
            end
          )
      end
    )
  end

  @type letter_tuple :: {char()}
  @type tuple_of_tuples :: {letter_tuple()}
  @spec parse(binary()) :: {tuple_of_tuples()}
  defp parse(input) do
    Enum.map(String.split(input, "\n", trim: true), fn x ->
      List.to_tuple(String.graphemes(x))
    end)
    |> List.to_tuple()
  end
end
