defmodule TimeManagerWeb.UserTeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.UserTeam

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    user_teams = Accounts.list_user_teams()
    render(conn, "index.json", user_teams: user_teams)
  end

  # Fonction pour lister les utilisateurs d'une équipe spécifique
  def list_users(conn, %{"team_id" => team_id}) do
    users = Accounts.list_users_by_team_id(team_id)

    case users do
      [] ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "No users found for this team"})
      _ ->
        conn
        |> put_status(:ok)
        |> json(%{data: users})
    end
  end

  def create(conn, %{"user_team" => user_team_params}) do
    case Accounts.create_user_team(user_team_params) do
      {:ok, %UserTeam{} = user_team} ->
        conn
        |> put_status(:created)
        |> render("show.json", user_team: user_team)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.UserTeamJSON, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_team = Accounts.get_user_team!(id)
    render(conn, "show.json", user_team: user_team)
  end

  def update(conn, %{"id" => id, "user_team" => user_team_params}) do
    user_team = Accounts.get_user_team!(id)

    with {:ok, %UserTeam{} = user_team} <- Accounts.update_user_team(user_team, user_team_params) do
      render(conn, "show.json", user_team: user_team)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_team = Accounts.get_user_team!(id)

    with {:ok, %UserTeam{}} <- Accounts.delete_user_team(user_team) do
      send_resp(conn, :no_content, "")
    end
  end
end
