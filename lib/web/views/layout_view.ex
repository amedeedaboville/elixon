defmodule Elixon.Web.LayoutView do
  use Phoenix.HTML

  use Elixon.Web, :view
  #  def render(_, assigns) do
  #    Map.putassigns.
  #    render "app.html", :page_title: "Elixon"
  #  end

  def title do
    "Elixon Home Controller"
  end
  def stylesheet_pack_tag(pack_name, opts \\ []) do
    src = "packs/#{pack_name}.css" #todo: call static_path
    Phoenix.HTML.Tag.content_tag(:link, "",
                                 Keyword.put_new(opts, :rel, "stylesheet")
                                 |> Keyword.put_new(:href, src)
    )
  end
  def javascript_pack_tag(pack_name, opts \\ []) do
    src = "packs/#{pack_name}.js" #todo: call static_path
    Phoenix.HTML.Tag.content_tag(:script, "",
                         Keyword.put_new(opts, :src, src)
                         |> Keyword.put_new(:integrity, "true")
                         |> Keyword.put_new(:crossorigin, "anonymous")
                         |> Keyword.put_new(:rel, "preload")
    )
  end

  def csrf_meta_tags do
    Phoenix.HTML.Tag.csrf_meta_tag()
  end
  def header_tags do
    "no header"
  end
  def add_rtl_body_class(class_list) do
    ""
  end

end
