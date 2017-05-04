defmodule BlueprintTest do
  use ExUnit.Case

  test "run with no modules" do
    assert Blueprint.run([]).total == 0
  end

  test "run with one module but no tests" do
    defmodule MyModule do
      def something(), do: 1
    end

    assert Blueprint.run([MyModule]).total == 0
  end

  test "run with one module with tests" do
    defmodule MyModuleV2 do
      def test_add() do
        Blueprint.Assertions.assertEqual(1 + 1, 2)
      end
    end

    results = Blueprint.run([MyModuleV2])

    assert results.total == 1
    assert results.passed == 1
    assert results.failed == 0
  end

  test "run with one module with multiple tests" do
    defmodule MyModuleV3 do
      def test_add() do
        Blueprint.Assertions.assertEqual(1 + 1, 2)
      end

      def test_substract() do
        Blueprint.Assertions.assertEqual(2 - 1, 1)
      end
    end

    results = Blueprint.run([MyModuleV3])

    assert results.total == 2
    assert results.passed == 2
    assert results.failed == 0
  end

  test "run with one module with multiple tests and one failed" do
    defmodule MyModuleV4 do
      def test_add() do
        Blueprint.Assertions.assertEqual(1 + 1, 2)
      end

      def test_substract() do
        Blueprint.Assertions.assertEqual(2 - 1, 2)
      end
    end

    results = Blueprint.run([MyModuleV4])

    assert results.total == 2
    assert results.passed == 1
    assert results.failed == 1
  end

  test "run with multiple modules" do
    defmodule MyModuleOne do
      def test_add() do
        Blueprint.Assertions.assertEqual(1 + 1, 2)
      end

      def test_substract() do
        Blueprint.Assertions.assertEqual(2 - 1, 1)
      end
    end

    defmodule MyModuleTwo do
      def test_multiply() do
        Blueprint.Assertions.assertEqual(1 * 1, 1)
      end

      def test_divide() do
        Blueprint.Assertions.assertEqual(1/1, 1)
      end
    end

    results = Blueprint.run([MyModuleOne, MyModuleTwo])

    assert results.total == 4
    assert results.passed == 4
    assert results.failed == 0
  end
end
