defmodule Helpers.Types do
  @moduledoc false

  def to_integer(value) do
    cond do
      is_binary(value) -> String.to_integer(value)
      is_integer(value) -> value
      true -> :error
    end
  end
end
