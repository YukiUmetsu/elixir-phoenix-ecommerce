defmodule Helpers.Dates do
  @moduledoc false

  def to_mdy(date) do
    "#{date.month}/#{date.day}/#{date.year}"
  end
end
