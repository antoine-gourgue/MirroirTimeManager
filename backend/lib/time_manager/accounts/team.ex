defmodule TimeManager.Accounts.Team do
  use Ecto.Schema
  import Ecto.Changeset  # Importation de Ecto.Changeset
  alias TimeManager.Repo
  alias TimeManager.Accounts.User

  schema "teams" do
    field :name, :string
    field :manager_id, :id  # Ajoute le champ manager_id pour faire référence au manager

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :manager_id])  # Cast les champs name et manager_id
    |> validate_required([:name, :manager_id])  # S'assurer que name et manager_id sont obligatoires
    |> validate_manager_id()  # Valide que le manager_id est correct
  end

  # Valider que le manager_id correspond à un utilisateur ayant le rôle de manager
  defp validate_manager_id(changeset) do
    manager_id = get_field(changeset, :manager_id)  # Utilisation de get_field pour récupérer manager_id

    case Repo.get(User, manager_id) do
      nil ->
        # Ajouter une erreur au changeset s'il n'y a pas de manager valide
        add_error(changeset, :manager_id, "Invalid manager ID")  # Utilisation de add_error pour ajouter une erreur
      _user ->
        changeset
    end
  end
end
