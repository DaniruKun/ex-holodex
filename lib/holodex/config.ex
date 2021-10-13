defmodule Holodex.Config do
  @moduledoc false
  @default_timeout 5
  @default_token ""

  def api_token, do: config_or_env(:api_token) || @default_token
  def timeout, do: @default_timeout

  defp config_or_env(key) do
    case Application.fetch_env(:holodex, key) do
      {:ok, {:system, var}} ->
        System.get_env(var)

      {:ok, {:system, var, default}} ->
        case System.get_env(var) do
          nil -> default
          val -> val
        end

      {:ok, value} ->
        value

      :error ->
        nil
    end
  end
end
