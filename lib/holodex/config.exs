defmodule Holodex.Config do
  @default_timeout 5

  def api_token, do: config_or_env(:api_token)
  
  defp config_or_env(key) do
    case Application.fetch_env(:nadia, key) do
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
