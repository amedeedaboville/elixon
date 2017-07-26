defmodule Elixon.Notification do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixon.Notification

  schema "notifications" do
    field :activity_id, :integer
    field :activity_type, :string
    timestamps(inserted_at: :created_at)
    belongs_to :account, Account
    belongs_to :from_account, Account, foreign_key: :from_account_id
  end

  @activities ~w(Mention Status Follow FollowRequest Favourite)
  @type_class_map %{
    mention:        "Mention",
    reblog:         "Status",
    follow:         "Follow",
    follow_request: "FollowRequest",
    favourite:      "Favourite",
  }

  @status_includes {:account,
                    :stream_entry,
                    :media_attachments,
                    :tags,
                    mentions: :account,
                    reblog: {
                      :stream_entry,
                      :account,
                      :media_attachments,
                      :tags,
                      mentions: :account
                    }}

  #belongs_to :activity, polymorphic: true

   def type(activity) do
    @type_class_map.invert[activity].to_sym
   end

  def target_status (activity) do
    case type(activity) do
     :reblog -> activity.reblog
     :favourite -> activity.status
     :mention -> activity.status
    end
  end

  def activity_types_from_types(types) do
    Enum.map( types, fn t ->  @type_class_map[t.to_sym] end)#.compact?
  end

  @doc false
  def changeset(%Notification{} = notif, attrs) do
    notif
    |> cast(attrs, [:username])
    |> validate_required([:username])
    |> validate_inclusion(:activity_type, @activities)
    |> unique_constraint([:account_id, :activity_type, :activity_id])
  end
end
