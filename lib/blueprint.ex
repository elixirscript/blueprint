defmodule Blueprint do
  @moduledoc """
  Minimal unit testing framework.
  """

  @doc """
  Goes through the given modules to run test functions defined.
  A function is considered a test is it begins with `test_` and
  has an arity of 0. 

  This function will return a map with the total number of tests ran,
  the number of tests passed and the number of tests failed
  """
  @spec run([atom]) :: map
  def run(modules) do
    results = %{passed: 0, failed: 0}

    results = modules
    |> Enum.map(fn module -> 
      {module, filter_test_functions(module)}
    end)
    |> Enum.reduce(results, fn {module, test_functions}, next_results -> 
      call_test_functions(module, test_functions, next_results)
    end)

    Map.put(results, :total, results.passed + results.failed)
  end

  defp call_test_functions(module, test_functions, results) do
    Enum.reduce(test_functions, results, fn {function, _}, next_results ->
      try do
        apply(module, function, [])
        %{next_results | passed: next_results.passed + 1}
      rescue
        x in [Blueprint.AssertError] ->
          IO.puts("#{inspect module}.#{function}: #{x.message}")
          %{next_results | failed: next_results.failed + 1}
      end
    end)
  end

  defp filter_test_functions(module) do
    Enum.filter(module.__info__(:functions), fn 
      {function, 0} ->
        str_function = Atom.to_string(function)
        case str_function do
          "test_" <> _ ->
            true
          _ ->
            false
        end
      _ ->
        false
    end)
  end

end
