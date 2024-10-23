defmodule TimeManagerWeb.TeamJSON do
  alias TimeManager.Accounts.Team

  @doc """
  Renders a list of teams.
  """
  def index(%{teams: teams}) do
    %{data: for(team <- teams, do: data(team))}
  end

  @doc """
  Renders a single team.
  """
  def show(%{team: team}) do
    %{data: data(team)}
  end

  @doc """
  Renders a simple error message.
  """
  def error(%{message: message}) do
    %{error: message}
  end

  defp data(%Team{} = team) do
    %{
      id: team.id,
      name: team.name,
      manager_id: team.manager_id,
      inserted_at: team.inserted_at,
      updated_at: team.updated_at
    }
  end
end
