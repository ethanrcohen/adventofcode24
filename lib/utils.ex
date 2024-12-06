defmodule AdventOfCode.Utils do
  @moduledoc """
  Utility functions shared across Advent of Code solutions.
  """

  @doc """
  Reads the content of a file at the given file path and prints it to the console.

  ## Parameters

    - file_path: The path to the file to be read.

  ## Examples

      iex> AdventOfCode.Utils.read_file("path/to/file.txt")
      File content:
      "This is the content of the file."

  If the file cannot be read, an error message will be printed.

  """
  def read_file(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        content

      {:error, reason} ->
        IO.puts("Failed to read file: #{reason}")
    end
  end
end
