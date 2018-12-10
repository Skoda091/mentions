defmodule MentionsWeb.MentionControllerTest do
  use MentionsWeb.ConnCase

  alias Mentions.Tweets

  @create_attrs %{
    author: "some author",
    created_at: "Sat Dec 01 07:55:00 +0000 2018",
    retweet_count: 42,
    tw_id: 42,
    tw_text: "some tw_text"
  }
  @update_attrs %{
    author: "some updated author",
    created_at: "Sat Dec 01 10:55:00 +0000 2018",
    retweet_count: 43,
    tw_id: 43,
    tw_text: "some updated tw_text"
  }
  @invalid_attrs %{author: nil, created_at: nil, retweet_count: nil, tw_id: nil, tw_text: nil}

  def fixture(:mention) do
    {:ok, mention} = Tweets.create_mention(@create_attrs)
    mention
  end

  describe "index" do
    test "lists all mentions", %{conn: conn} do
      conn = get(conn, mention_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Mentions"
    end
  end

  describe "new mention" do
    test "renders form", %{conn: conn} do
      conn = get(conn, mention_path(conn, :new))
      assert html_response(conn, 200) =~ "New Mention"
    end
  end

  describe "create mention" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, mention_path(conn, :create), mention: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == mention_path(conn, :show, id)

      conn = get(conn, mention_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Mention"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, mention_path(conn, :create), mention: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Mention"
    end
  end

  describe "edit mention" do
    setup [:create_mention]

    test "renders form for editing chosen mention", %{conn: conn, mention: mention} do
      conn = get(conn, mention_path(conn, :edit, mention))
      assert html_response(conn, 200) =~ "Edit Mention"
    end
  end

  describe "update mention" do
    setup [:create_mention]

    test "redirects when data is valid", %{conn: conn, mention: mention} do
      conn = put(conn, mention_path(conn, :update, mention), mention: @update_attrs)
      assert redirected_to(conn) == mention_path(conn, :show, mention)

      conn = get(conn, mention_path(conn, :show, mention))
      assert html_response(conn, 200) =~ "some updated author"
    end

    test "renders errors when data is invalid", %{conn: conn, mention: mention} do
      conn = put(conn, mention_path(conn, :update, mention), mention: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Mention"
    end
  end

  describe "delete mention" do
    setup [:create_mention]

    test "deletes chosen mention", %{conn: conn, mention: mention} do
      conn = delete(conn, mention_path(conn, :delete, mention))
      assert redirected_to(conn) == mention_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, mention_path(conn, :show, mention))
      end)
    end
  end

  defp create_mention(_) do
    mention = fixture(:mention)
    {:ok, mention: mention}
  end
end
