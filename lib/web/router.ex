defmodule Elixon.Web.Router do
  use Elixon.Web, :router
  alias Elixon.Web

  pipeline :api do
    plug :accepts, ["json"]
  end
    
  get  "/", Elixon.Web.HomeController, :index
  get "/about",      AboutController, :show
  get "/about/more", AboutController, :more
  get "/terms",      AboutController, :terms
  get "/web/*any", Elixon.Web.HomeController, :index, as: :web
    
  scope "/api", Elixon.Web do
    pipe_through :api

    # PubSubHubbub outgoing subscriptions
    resources "/subscriptions", SubscriptionsController, only: [:show]
    post "/subscriptions", SubscriptionsController, :update

    # PubSubHubbub incoming subscriptions
    post "/push", PushController, :update, as: :push

    post "/salmon", SalmonController, :update,  as: :salmon
    get "/oembed", OEmbedController, :show, as: :oembed

    # JSON / REST API
    scope "/v1", Api.V1 do
      resources "/statuses", StatusController, only: [:create, :show, :delete] do
        scope "/", Elixon.Web.Status do
          resources "/reblogged_by", RebloggedByAccountsController, only: [:index]
          resources "/favourited_by",FavouritedByAccountsController, only: [:index]
          resources "/reblog", ReblogController, only: [:create], singleton: true
          post "/unreblog", ReblogController, :delete

          resources "/favourite", FavouritesController, only: [:create], singleton: true
          post "/unfavourite", FavouritesController, :delete

          resources "/mute", MutesController, only: [:create], singleton: true
          post "/unmute", MutesController, :delete, as: :delete
        end

        get "/context", StatusController, :context, as: :context
        get "/card", StatusController, :card, as: :card
      end

      scope "/timelines" do
        resources "/home", Elixon.Web.HomeController, only: [:show], singleton: true
        resources "/public", PublicController, only: [:show], singleton: true
        resources "/tag", TagController, only: [:show]
      end
      resources "/streaming", StreamingController, only: [:index]

      get "/search", SearchController, :index, as: :search

      resources "/follows",     FollowsController,    only: [:create]
      resources "/media",       MediaController,      only: [:create]
      resources "/apps",        AppsController,       only: [:create]
      resources "/blocks",      BlocksController,     only: [:index]
      resources "/mutes",       MutesController,      only: [:index]
      resources "/favourites",  FavouritesController, only: [:index]
      resources "/reports",     ReportsController,    only: [:index, :create]

      resources "/instance",    InstanceController,     only: [:show], singleton: true
      resources "/domain_blocks", DomainBlocksController, only: [:show, :create, :delete], singleton: true

      resources "/follow_requests", FollowRequestsController, only: [:index] do
        post "/authorize", FollowRequestController, :authorize, as: :authorize
        post "/reject", FollowRequestController, :reject, as: :reject
      end

      resources "/notifications", NotificationsController, only: [:index, :show]
      scope "/notifications" do
        post "/clear", NotificationsController, :clear
        post "/dismiss", NotificationsController, :dismiss
      end

      scope "/accounts" do
        get "/verify_credentials",  CredentialsController, :show
        patch "/update_credentials",CredentialsController, :update
        resources "/search", SearchController, only: [:show], singleton: true
        resources "/relationships", RelationshipsController, only: [:index]
      end
      resources "/accounts", AccountController, only: [:show] do
        resources "/statuses", StatusesController, only: [:index]
        resources "/followers", FollowersController, only: [:index]
        resources "/following", FollowingController, only: [:index]

        post "/follow",   AccountsController, :follow, as: :follow
        post "/unfollow", AccountsController, :unfollow, as: :unfollow
        post "/block",    AccountsController, :block, as: :block
        post "/unblock",  AccountsController, :unblock, as: :unblock
        post "/mute",     AccountsController, :mute, as: :mute
        post "/unmute",   AccountsController, :unmute, as: :unmute
      end
    end

    scope "/web" do
      resources "/settings", SettingsController, only: [:update], singleton: true
      resources "/push_subscriptions", PushSubscriptionsController, only: [:create] do
          put "/update", PushSubscriptionsController, :update, as: :update
      end
    end
  end
end
