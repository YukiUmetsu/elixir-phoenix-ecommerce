defmodule Mango.ReleaseTasks do
  @moduledoc false

  @otp_app :mango

  def seed do
    "#{seed_path(@otp_app)}/*.exs"
    |> Path.wildcard()
    |> Enum.sort()
    |> Enum.each(&run_seed_script/1)
  end

  defp run_seed_script(seed_script) do
    IO.puts "Running seed script #{seed_script}.."
    Code.eval_file(seed_script)
  end

  defp seed_path(app),
       do: :code.priv_dir(app, ["repo", "seeds"])
end