defmodule Mango.ReleaseTasks do
  @moduledoc false

  @otp_app :myapp_api
  @start_apps [:logger, :ssl, :postgrex, :ecto]

  def seed do
    init(@otp_app, @start_apps)

    "#{seed_path(@otp_app)}/*.exs"
    |> Path.wildcard()
    |> Enum.sort()
    |> Enum.each(&run_seed_script/1)

    stop()
  end

  defp run_seed_script(seed_script) do
    IO.puts "Running seed script #{seed_script}.."
    Code.eval_file(seed_script)
  end

  defp seed_path(app),
       do: priv_dir(app, ["repo", "seeds"])
end