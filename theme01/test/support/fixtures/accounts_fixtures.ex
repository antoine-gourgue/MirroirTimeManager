defmodule Theme01.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Theme01.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> Theme01.Accounts.create_user()

    user
  end
end
