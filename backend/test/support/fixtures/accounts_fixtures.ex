defmodule TimeManager.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Accounts` context.
  """
  alias TimeManager.Accounts.Role
  alias TimeManager.Repo
  alias TimeManager.Accounts.User
  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    role = Repo.insert!(%Role{name: "Default Role"})
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password: "some password",
        username: "some username",
        role_id: role.id
      })
      |> TimeManager.Accounts.create_user()

    user
  end

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TimeManager.Accounts.create_role()

    role
  end

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    manager = user_fixture()

    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some team",
        manager_id: manager.id
      })
      |> TimeManager.Accounts.create_team()

    team
  end



  @doc """
  Generate a user_team.
  """
  def user_team_fixture(attrs \\ %{}) do
    # Vous pouvez ici passer un `user` et un `team` déjà créés si nécessaire, sinon en créer de nouveaux
    user = Map.get(attrs, :user, user_fixture())
    team = Map.get(attrs, :team, team_fixture())

    # Fusion des attributs passés avec les valeurs par défaut
    merged_attrs = attrs
                   |> Enum.into(%{
      user_id: user.id,
      team_id: team.id
    })

    {:ok, user_team} = TimeManager.Accounts.create_user_team(merged_attrs)
    user_team
  end

end
