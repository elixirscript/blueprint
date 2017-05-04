defmodule Blueprint.Assertions.Test do
  use ExUnit.Case
  alias Blueprint.Assertions

  test "assertEquals returns true" do
    assert Assertions.assertEqual(1 + 1, 2) == nil
  end

  test "assertEquals throws on not equal" do
    assert_raise Blueprint.AssertError, "Expected: 3, Actual: 2", fn ->
      Assertions.assertEqual(1 + 1, 3)
    end
  end

  test "assertEquals throws custom message on not equal" do
    assert_raise Blueprint.AssertError, "Incorrect", fn ->
      Assertions.assertEqual(1 + 1, 3, "Incorrect")
    end
  end
end
