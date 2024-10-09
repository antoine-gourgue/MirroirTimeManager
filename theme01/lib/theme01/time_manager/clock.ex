defmodule Theme01.TimeManager.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :time, :naive_datetime
    field :status, :boolean
    belongs_to :user, Theme01.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
    |> assoc_constraint(:user)
  end
end
