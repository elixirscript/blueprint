defmodule Blueprint.Assertions do
  @moduledoc """
  A set of functions to use for testing 
  """

  @doc """
  Compares first to second for equality.
  Raises Blueprint.AssertError if the values do not match
  """
  @spec assertEqual(any, any, binary) :: nil
  def assertEqual(first, second, message \\ nil) do
    case first == second do
      true ->
        nil
      false ->
        msg = if message, do: message, else: "Expected: #{inspect second}, Actual: #{first}"
        raise Blueprint.AssertError, message: msg
    end
  end

end