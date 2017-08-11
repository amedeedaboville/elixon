defmodule Elixon.Web.AboutView do
  use Phoenix.HTML

  use Elixon.Web, :view

  def title do
    "Elixon About View"
  end
  def display_name(contact) do
  #  display_name(contact.contact_account)
  "display name"
  end

  def t(string, opts \\ []) do
    string
  end
  def link_to(title, pack_name, opts \\ []) do
    src = "packs/#{pack_name}.css" #todo: call static_path
    Phoenix.HTML.Tag.content_tag(:link, title,
                                 Keyword.put_new(opts, :rel, "stylesheet")
                                 |> Keyword.put_new(:href, src)
    )
  end
  def asset_pack_path(conn, pack) do
    Elixon.Web.Router.Helpers.static_path(conn, "/packs/#{pack}")
  end
  def image_tag(src, opts \\ []) do
    Phoenix.HTML.Tag.img_tag(src, opts)
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


  def fa_icon(icon, opts \\ []) do
    #classes << 'fa'
    #class_names += icon.split(' ').map { |cl| "fa-#{cl}" }

    Phoenix.HTML.Tag.content_tag(:i, Keyword.put_new([], :class, "fa-leaf"))
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
