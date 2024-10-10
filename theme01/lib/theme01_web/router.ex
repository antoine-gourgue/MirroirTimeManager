defmodule Theme01Web.Router do
  use Theme01Web, :router

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/api", Theme01Web do
    pipe_through :api

    # User Routes
    get "/users", UserController, :index           # GET method to list users with optional params (email, username)
    get "/users/:id", UserController, :show        # GET method to show a specific user
    post "/users", UserController, :create         # POST method to create a new user
    put "/users/:id", UserController, :update      # PUT method to update a user
    delete "/users/:id", UserController, :delete   # DELETE method to remove a user

    # Working Time Routes
    get "/workingtime/:user_id", WorkingTimeController, :index  # GET all working times for a user
    get "/workingtime/:user_id/:id", WorkingTimeController, :show  # GET a specific working time for a user
    post "/workingtime/:user_id", WorkingTimeController, :create   # POST a new working time for a user
    put "/workingtime/:id", WorkingTimeController, :update         # PUT method to update a working time entry
    delete "/workingtime/:id", WorkingTimeController, :delete      # DELETE a working time entry

    # Clock Routes
    get "/clocks/:user_id", ClockController, :show_by_user       # GET method to show a specific clock by its ID
    post "/clocks/:user_id", ClockController, :create     # POST method for clock-in/clock-out
  end
end
