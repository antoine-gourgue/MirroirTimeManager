defmodule Theme01Web.ClockController do
  use Theme01Web, :controller

  alias Theme01.TimeManager
  alias Theme01.TimeManager.Clock

  action_fallback Theme01Web.FallbackController

  # Affiche tous les clocks d'un utilisateur
  def show_by_user(conn, %{"user_id" => user_id}) do
    clocks = TimeManager.get_clocks_by_user_id(user_id)
    render(conn, :index, clocks: clocks)
  end

  # Crée un nouveau clock
  def create(conn, %{"clock" => clock_params, "user_id" => user_id}) do
    clock_params = Map.put(clock_params, "user_id", user_id)

    with {:ok, %Clock{} = clock} <- TimeManager.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clock/#{user_id}")
      |> render(:show, clock: clock)
    end
  end
end
