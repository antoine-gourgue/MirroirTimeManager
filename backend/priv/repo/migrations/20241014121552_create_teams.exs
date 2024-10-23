defmodule TimeManager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :manager_id, references(:users, on_delete: :nothing)  # Ajout de la référence à la table users

      timestamps(type: :utc_datetime)
    end

    create index(:teams, [:manager_id])  # Création d'un index pour la colonne manager_id
  end
end
