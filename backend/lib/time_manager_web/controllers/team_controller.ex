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

  def create(conn, %{"team" => team_params}) do
    case Accounts.create_team(team_params) do
      {:ok, team} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/teams/#{team.id}")  # Utilisation du sigil ~p pour générer la route
        |> render("show.json", team: team)

      {:error, _reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Invalid manager ID"})  # Simplification du message d'erreur
    end
  end

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
end
