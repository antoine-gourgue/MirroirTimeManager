defmodule Theme01Web.UserController do
  use Theme01Web, :controller

  alias Theme01.Accounts
  alias Theme01.Accounts.User
  alias Theme01.TimeManager

  action_fallback Theme01Web.FallbackController

  # Lister tous les utilisateurs ou trouver un utilisateur par email et username
  def index(conn, %{"email" => email, "username" => username}) do
    case TimeManager.get_user_by_email_and_username(email, username) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      user ->
        json(conn, %{
          id: user.id,
          username: user.username,
          email: user.email,
          admin: user.admin
        })
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()

    json(conn, %{
      data: Enum.map(users, fn user ->
        %{
          id: user.id,
          username: user.username,
          email: user.email,
          admin: user.admin
        }
      end)
    })
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> json(%{
        id: user.id,
        username: user.username,
        email: user.email,
        admin: user.admin
      })
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    json(conn, %{
      id: user.id,
      username: user.username,
      email: user.email,
      admin: user.admin
    })
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      json(conn, %{
        id: user.id,
        username: user.username,
        email: user.email,
        admin: user.admin
      })
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
