defmodule Theme01Web.WorkingTimeController do
  use Theme01Web, :controller

  alias Theme01.TimeManager
  alias Theme01.TimeManager.WorkingTime

  action_fallback Theme01Web.FallbackController

  # Liste tous les working times d'un utilisateur avec des filtres optionnels sur les dates
  def index(conn, %{"user_id" => user_id, "start" => start, "end" => end_time}) do
    working_times = TimeManager.list_working_times_by_user_and_dates(user_id, start, end_time)
    render(conn, :index, working_times: working_times)
  end

  def index(conn, %{"user_id" => user_id}) do
    working_times = TimeManager.list_working_times_by_user(user_id)
    render(conn, :index, working_times: working_times)
  end

  # Crée une nouvelle période de travail
  def create(conn, %{"user_id" => user_id, "working_time" => working_time_params}) do
    working_time_params = Map.put(working_time_params, "user_id", user_id)

    with {:ok, %WorkingTime{} = working_time} <- TimeManager.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtime/#{user_id}/#{working_time.id}")
      |> render(:show, working_time: working_time)
    end
  end

  # Affiche une période de travail spécifique pour un utilisateur
  def show(conn, %{"user_id" => user_id, "id" => id}) do
    working_time = TimeManager.get_working_time_by_user!(user_id, id)
    render(conn, :show, working_time: working_time)
  end

  # Met à jour une période de travail
  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = TimeManager.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- TimeManager.update_working_time(working_time, working_time_params) do
      render(conn, :show, working_time: working_time)
    end
  end

  # Supprime une période de travail
  def delete(conn, %{"id" => id}) do
    working_time = TimeManager.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- TimeManager.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
