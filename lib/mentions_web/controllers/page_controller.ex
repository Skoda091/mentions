defmodule MentionsWeb.PageController do
  use MentionsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
