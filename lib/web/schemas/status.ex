defmodule Elixon.Status do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixon.Status

  #enum visibility: [:public, :unlisted, :private, :direct], _suffix: :visibility
  schema "statuses" do
      field :uri, :string
      field :text, :string, default: ""
      field :url, :string
      field :sensitive, :boolean, default: false
      field :visibility, :integer, default: 0
      field :application_id, :integer
      field :spoiler_text, :string, default: ""
      field :reply, :boolean, default: false
      field :favourites_count, :integer, default: 0
      field :reblogs_count, :integer, default: 0
      field :language, :string
      timestamps inserted_at: :created_at

      #belongs_to :application, : 'Doorkeeper::Application'
      belongs_to :account, Account #counter_cache: true, required: true
      belongs_to :in_reply_to_account, Account, foreign_key: :in_reply_to_account_id
      belongs_to :conversation, Conversation
      belongs_to :thread, Status,   foreign_key: :in_reply_to_id
      has_many   :replies, Status,  foreign_key: :in_reply_to_id
      belongs_to :reblog, Status, foreign_key: :reblog_of_id #, #counter_cache: :reblogs_count
      has_many :reblogs, Status, foreign_key: :reblog_of_id #inverse_of: :reblog, dependent: :delete
      has_many :favourites, Favourite, on_delete: :delete_all
      has_many :mentions, Mention, on_delete: :delete_all
      has_many :media_attachments, MediaAttachment, on_delete: :delete_all
      many_to_many :tags, Tag, join_through: :statuses_tags
      has_one :preview_card, PreviewCard, on_delete: :delete_all
      #Not sure about the rails 'as' here
      #has_one :activity, Notification, as: :activity, on_delete: :delete
  end


  @doc false
  def changeset(%Status{} = status, attrs) do
    status
    |> cast(attrs, [:username])
    |> validate_required([:username])
    |> unique_constraint(:uri)#, unless: :local?)
    #|> validate_presence(:text, unless: :reblog?)
    |> unique_constraint(:reblog)
    #|> validates_with(StatusLengthValidator)
  end
end

