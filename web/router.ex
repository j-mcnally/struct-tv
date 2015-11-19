defmodule Struct.Router do
  use Phoenix.Router
  use Phoenix.Router.Socket, mount: "/ws"

  channel "messages", Struct.Api.V1.MessagesChannel
  channel "streams", Struct.Api.V1.StreamsChannel


  pipeline :before do
    plug :super
    plug Exq.RouterPlug, namespace: "exq"
  end



  scope "/" do
    pipe_through :browser
    get "/", Struct.PageController, :index
    get "/logout", Struct.SessionController, :logout, as: :logout
  
    # Oauth
    scope path: "/oauth", alias: Struct.Oauth, helper: "oauth" do
      get "/github", GithubController, :github, as: :github
      get "/github/code", GithubController, :github_code, as: :github_code
      get "/meetup", MeetupController, :meetup, as: :meetup
      get "/meetup/code", MeetupController, :meetup_code, as: :meetup_code
    end


    # Api
    scope path: "/api", alias: Struct.Api, helper: "api" do
      scope path: "/v1", alias: V1, helper: "v1" do
        resources "/users", UserController
        resources "/channels", ChannelController
        resources "/streams", StreamController
        resources "/messages", MessageController
        resources "/meetups", MeetupController
      end
      post "/stream_check", StreamHookController, :check, as: :stream_check
      post "/stream_hook", StreamHookController, :hook, as: :stream_hook
    end

    get "/*slug", Struct.PageController, :index
  end

end
