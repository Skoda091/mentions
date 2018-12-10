defmodule MentionsWeb.MentionController do
  use MentionsWeb, :controller

  alias Mentions.Tweets
  alias Mentions.Tweets.Mention

  def index(conn, _params) do
    mentions = Tweets.list_mentions()
    render(conn, "index.html", mentions: mentions)
  end

  def new(conn, _params) do
    changeset = Tweets.change_mention(%Mention{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"mention" => mention_params}) do
    case Tweets.create_mention(mention_params) do
      {:ok, mention} ->
        conn
        |> put_flash(:info, "Mention created successfully.")
        |> redirect(to: mention_path(conn, :show, mention))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mention = Tweets.get_mention!(id)
    render(conn, "show.html", mention: mention)
  end

  def edit(conn, %{"id" => id}) do
    mention = Tweets.get_mention!(id)
    changeset = Tweets.change_mention(mention)
    render(conn, "edit.html", mention: mention, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mention" => mention_params}) do
    mention = Tweets.get_mention!(id)

    case Tweets.update_mention(mention, mention_params) do
      {:ok, mention} ->
        conn
        |> put_flash(:info, "Mention updated successfully.")
        |> redirect(to: mention_path(conn, :show, mention))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", mention: mention, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mention = Tweets.get_mention!(id)
    {:ok, _mention} = Tweets.delete_mention(mention)

    conn
    |> put_flash(:info, "Mention deleted successfully.")
    |> redirect(to: mention_path(conn, :index))
  end
end
