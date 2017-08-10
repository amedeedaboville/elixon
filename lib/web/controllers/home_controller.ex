defmodule Elixon.Web.HomeController do
  #before_action :set_initial_state_json
  use Elixon.Web, :controller
  #alias Elixon.{Repo, Notification, User}

  plug :authenticate

  def index(conn, _params) do
    render conn, "home/index.html", page_title: "Elixon", content: "Hello world?"
  end


  def authenticate(conn, _) do
    if Coherence.current_user(conn) do
      conn
    else
    #todo: single user mode
    #redirect_to(single_user_mode? ? account_path(Account.first) : about_path) unless user_signed_in?
      conn
      |> redirect(to: Elixon.Web.Router.Helpers.about_path(conn, :show))
      |> halt()
    end
  end

  defp set_initial_state_json() do
    #serializable_resource = Remodel.SerializableResource.new(
    #  serializer: InitialStateSerializer)
    #Remodel.map(InitialStatePresenter, initial_state_params)
    serializable_resource.to_json
    Poison.encode initial_state_params
  end

  defp initial_state_params() do
    %{
      #settings: Repo.Setting.find_by(user_id: current_user).data,
      #push_subscription: current_account.user.web_push_subscription(current_session),
      current_account: Repo.User,
      #token: current_session.token,
      admin: false,#Account.find_local(Setting.site_contact_username),
    }
  end
end
