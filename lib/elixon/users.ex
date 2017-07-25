defmodule Elixon.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixon.User

  schema "users" do
    field :email, :string, default: ""
    field :account_id, :integer
    field :encrypted_password, :string, default: ""
    field :reset_password_token, :string
    field :reset_password_sent_at, :utc_datetime
    field :remember_created_at, :utc_datetime
    field :sign_in_count, :integer, default: 0
    field :current_sign_in_at, :utc_datetime
    field :last_sign_in_at, :utc_datetime
    #field :current_sign_in_ip, :EctoNetwork.INET
    #field :last_sign_in_ip, :EctoNetwork.INET
    field :admin, :boolean, default: false
    field :confirmation_token, :string
    field :confirmed_at, :utc_datetime
    field :confirmation_sent_at, :utc_datetime
    field :unconfirmed_email, :string
    field :locale, :string
    field :encrypted_otp_secret, :string
    field :encrypted_otp_secret_iv, :string
    field :encrypted_otp_secret_salt, :string
    field :consumed_timestep, :integer
    field :otp_required_for_login, :boolean, default: false
    field :last_emailed_at, :utc_datetime
    field :otp_backup_codes, {:array, :string}
    field :filtered_languages, {:array, :string}, default: []
    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end
