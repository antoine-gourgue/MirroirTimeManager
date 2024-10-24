defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller
  alias TimeManager.Accounts
  alias TimeManager.Accounts.Team

  action_fallback TimeManagerWeb.FallbackController

  # Lister toutes les équipes
  def index(conn, _params) do
    teams = Accounts.list_teams()
    render(conn, "index.json", teams: teams)
  end

  # Lister toutes les équipes d'un manager
  def get_teams_by_manager_id(conn, %{"manager_id" => manager_id}) do
    teams = Accounts.list_teams_by_manager_id(manager_id)
    render(conn, "index.json", teams: teams)
  end

  # Créer une nouvelle équipe
  def create(conn, %{"team" => team_params}) do
    case Accounts.create_team(team_params) do
      {:ok, team} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/teams/#{team.id}")
        |> render("show.json", team: team)

      {:error, _reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Invalid manager ID"})
    end
  end

  # Mettre à jour une équipe existante
  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Accounts.get_team!(id)

    case Accounts.update_team(team, team_params) do
      {:ok, team} ->
        render(conn, "show.json", team: team)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(TimeManagerWeb.TeamJSON.error(%{changeset: changeset}))
    end
  end

  # Supprimer une équipe
  def delete(conn, %{"id" => id}) do
    team = Accounts.get_team!(id)

    case Accounts.delete_team(team) do
      {:ok, _team} ->
        send_resp(conn, :no_content, "")
      {:error, _reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Unable to delete team"})
    end
  end
end
