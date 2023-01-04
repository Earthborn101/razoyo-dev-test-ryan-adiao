defmodule RazoyoWeb.Router do
  use RazoyoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RazoyoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RazoyoWeb do
    pipe_through :browser

    live "/cars", CarsLive.Index, :index
    live "/cars/:id", CarsLive.Index, :show
  end
end
