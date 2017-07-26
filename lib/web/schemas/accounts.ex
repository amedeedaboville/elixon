defmodule Elixon.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixon.Account


  schema "accounts" do
	field :username, :string, default: ""
	field :domain, :string
	field :secret, :string, default: ""
	field :private_key, :string
	field :public_key, :string, default: ""
	field :remote_url, :string, default: ""
	field :salmon_url, :string, default: ""
	field :hub_url, :string, default: ""
	field :note, :string, default: ""
	field :display_name, :string, default: ""
	field :uri, :string, default: ""
	field :url, :string
	field :avatar_file_name, :string
	field :avatar_content_type, :string
	field :avatar_file_size, :integer
	field :avatar_updated_at, :utc_datetime
	field :header_file_name, :string
	field :header_content_type, :string
	field :header_file_size, :integer
	field :header_updated_at, :utc_datetime
	field :avatar_remote_url, :string
	field :subscription_expires_at, :utc_datetime
	field :silenced, :boolean, default: false
	field :suspended, :boolean, default: false
	field :locked, :boolean, default: false
	field :header_remote_url, :string, default: ""
	field :statuses_count, :integer, default: 0
	field :followers_count, :integer, default: 0
	field :following_count, :integer, default: 0
	field :last_webfingered_at, :utc_datetime
    has_many :notifications, Notification
	timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end
