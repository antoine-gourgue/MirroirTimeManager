defmodule TimeManager.Accounts.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeManager.Repo
  alias TimeManager.Accounts.User

  schema "teams" do
    field :name, :string
    field :manager_id, :id  # Référence au manager

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :manager_id])
    |> validate_required([:name, :manager_id])
    |> validate_manager_id()  # Validation personnalisée pour le manager
  end

  defp validate_manager_id(changeset) do
    case get_field(changeset, :manager_id) do
      nil ->
        add_error(changeset, :manager_id, "Manager ID is required")
      manager_id ->
        case Repo.get(User, manager_id) do
          nil ->
            add_error(changeset, :manager_id, "Invalid manager ID")
          _user ->
            changeset
        end
    end
  end
end
