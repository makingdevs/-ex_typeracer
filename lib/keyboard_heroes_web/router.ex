defmodule KeyboardHeroesWeb.Router do
  use KeyboardHeroesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug KeyboardHeroes.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KeyboardHeroesWeb do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/", PageController, :index
    get "/racer/:name_rom", PageController, :racer
    get "/racer", PageController, :racer
    post "/", PageController, :login
    post "/logout", PageController, :logout
    post "/new_user", PageController, :new_user
    get "/recovery/:token/:username", PageController, :recovery
    post "/restore_pass", PageController, :restore_pass
  end

  scope "/ranking", KeyboardHeroesWeb do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/", RankingController, :index
  end


  scope "/auth", KeyboardHeroesWeb do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/auth", KeyboardHeroesWeb do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/login", KeyboardHeroesWeb do
    pipe_through [:browser, :auth] # Use the default browser stack
    get "/", LoginController, :index
    post "/", LoginController, :login
    post "/logout", LoginController, :logout
  end

	if Mix.env == :dev do
		forward "/sent_emails", Bamboo.SentEmailViewerPlug
	end

end
