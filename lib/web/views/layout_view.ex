defmodule Elixon.Web.LayoutView do
  use Elixon.Web, :view
  #  def render(_, assigns) do
  #    Map.putassigns.
  #    render "app.html", :page_title: "Elixon"
  #  end
  def title do
    "Awesome New Title!"
  end
  def stylesheet_pack_tag(param, opts) do
    "linke to this stylesheet mate:"
  end
  def javascript_pack_tag(filename, opts) do
    "some Javyscript"
  end
  
  def csrf_meta_tags do
    ""
  end
  def header_tags do
    "no header"
  end
  def add_rtl_body_class(class_list) do
    ""
  end

end
