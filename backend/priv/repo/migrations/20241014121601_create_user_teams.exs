defmodule TimeManager.Repo.Migrations.CreateUserTeams do
  use Ecto.Migration

  def change do
    create table(:user_teams) do
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:user_teams, [:user_id])
    create index(:user_teams, [:team_id])

    create unique_index(:user_teams, [:user_id, :team_id], name: :user_teams_user_id_team_id_index)
  end
end
