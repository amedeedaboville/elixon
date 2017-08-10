defmodule Elixon.Web.AboutController do
  use Elixon.Web, :controller

  plug :set_body_classes
  plug :set_hostname
  plug :set_instance_presenter, only: [:show, :more, :terms]

  @initial_state_params %{
      settings: {},
      token: "",#,current_session.token,
    }
  def t(string) do
    string
  end
  def more(conn, _) do
    conn.assign(:page_title, @site_hostname)
    render conn, "more.html"
  end
  def show(conn, _params) do
    render conn, "show.html", page_title: "Elixon", content: "Hello world?", root_url: "/about", user_signed_in: false, about_more_path: "/about_more"
  end

  def index(conn, _params) do
    render conn, "home/index.html", page_title: "Elixon", content: "Hello world?"
  end
  def new_user(conn, _params) do
    changeset = Elixon.User.changeset(%Elixon.User{})
  end

  def create(conn, _params) do
    changeset = Elixon.User.changeset(%Elixon.User{})
    #User.new.tap(&:build_account)
    render conn, "_registrations.html", changeset: changeset
  end

  def set_hostname(conn, _) do
    assign(conn, :site_hostname,  "localhosty")
  end
  def set_instance_presenter(conn, _) do
    assign(conn, :instance_presenter,  "new_instance_presenter")
  end

  def set_body_classes(conn, _) do
    assign(conn, :body_classes,  "about-body")
  end
end
