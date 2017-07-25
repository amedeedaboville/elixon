defmodule Elixon.Web.Api.V1.NotificationsController do
  #No auth for now, will also have to figure out how to map these actions to phoenix.
  #before_action -> { doorkeeper_authorize! :read }
  #before_action :require_user!
  #after_action :insert_pagination_headers, only: :index
  #also, no pagination for now as Mastodon uses an (obscure?) IETF  proposal called LinkHeaders
  use Elixon.Web, :controller
  alias Elixon.{Repo, Notification, User}

  plug :load_resource, model: Elixon.Notification
  plug :load_resource, model: Elixon.Notification


  @notifications_limit 15
  def index(conn, id) do
    conn |> json(conn.notifications)
    #  each_serializer: REST.NotificationSerializer,
    #  relationships: StatusRelationshipsPresenter.new(target_statuses_from_notifications, current_user.account_id)
    
  end

  def show(conn, %{"id" => id}) do
    conn |> json(Repo.Notifications.find(id) |> NotificationSerializer.to_map)
  end

  #current_user = Elixon.Guardian.Plug.current_resource()# conn)
  
  #owned_boards = current_user |>
  #assoc(:notifications)
  #    |> Notifications.preload_all
  #    |> Repo.all
  def clear(conn, _params) do
    #current_user |> Repo.Assoc.assoc(:notifications) |> Repo.delete
    conn |> render_empty
  end

  def dismiss(conn, id) do
    #current_user |> Repo.Assoc.assoc(:notifications) |> Repo.find(id) |> Repo.delete
    conn |> render_empty
  end

  defp load_notifications(id) do
    #Not going to cache for now
    #cache_collection paginated_notifications, Notification
    paginated_notifications(id)
  end

  defp paginated_notifications(id) do
    browserable_account_notifications(id) |>
    Elixon.Repo.sort(:id, :since_id) |>
    Elixon.Repo.paginate(page_size: @notifications_limit)
  end

  def browserable_account_notifications(id) do
    Notifications.preload_all |> Elixon.Repo.get(id)
  end

  def target_statuses_from_notifications(notifications) do
    notifications |> Enum.filter_map( &is_nil/1, fn notif -> notif.target_status end)
  end

  #def insert_pagination_headers() do
  #  set_pagination_headers(next_path, prev_path)
  #end

  #def next_path() do
  #  unless @notifications.empty? do
  #    api_v1_notifications_url pagination_params(max_id: pagination_max_id)
  #  end
  #end

  #def prev_path() do
  #  unless @notifications.empty? do
  #    api_v1_notifications_url pagination_params(since_id: pagination_since_id)
  #  end
  #end

  #def pagination_max_id() do
  #  @notifications.last.id
  #end

  #def pagination_since_id() do
  #  @notifications.first.id
  #end

  #def exclude_types() do
  #  val = params.permit(exclude_types: [])[:exclude_types] || []
  #  case val do
  #    a when is_list(a) -> a
  #    a -> [a]
  #  end
  #end

  #def pagination_params(core_params) do
  #  params.permit(:limit, exclude_types: []).merge(core_params)
  #end
end
