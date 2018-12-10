defmodule MentionsWeb.Router do
  use MentionsWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", MentionsWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/mentions", MentionController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", MentionsWeb do
  #   pipe_through :api
  # end
end
