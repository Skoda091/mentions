defmodule Mentions.TweetsTest do
  use Mentions.DataCase
  import Mox

  alias Mentions.Tweets
  alias Mentions.Tweets.Services.TwitterMock

  describe "mentions" do
    alias Mentions.Tweets.Mention

    @valid_attrs %{
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

    def mention_fixture(attrs \\ %{}) do
      {:ok, mention} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tweets.create_mention()

      mention
    end

    test "list_mentions/0 returns all mentions" do
      mention = mention_fixture()
      assert Tweets.list_mentions() == [mention]
    end

    test "fetch_recent_mention/0 returns recent mention from api" do
      expect(TwitterMock, :fetch_recent_mention, fn attrs ->
        send(self(), {:fetch_recent_mention, attrs})
        {:ok, @valid_attrs}
      end)
      assert Tweets.fetch_recent_mention([screen_name: "josevalim", count: 1]) == @valid_attrs
      assert_received {:fetch_recent_mention, [screen_name: "josevalim", count: 1]}
    end

    test "get_mention!/1 returns the mention with given id" do
      mention = mention_fixture()
      assert Tweets.get_mention!(mention.id) == mention
    end

    test "create_mention/1 with valid data creates a mention" do
      assert {:ok, %Mention{} = mention} = Tweets.create_mention(@valid_attrs)
      assert mention.author == "some author"
      assert mention.created_at == "Sat Dec 01 07:55:00 +0000 2018"
      assert mention.retweet_count == 42
      assert mention.tw_id == 42
      assert mention.tw_text == "some tw_text"
    end

    test "create_mention/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tweets.create_mention(@invalid_attrs)
    end

    test "update_mention/2 with valid data updates the mention" do
      mention = mention_fixture()
      assert {:ok, mention} = Tweets.update_mention(mention, @update_attrs)
      assert %Mention{} = mention
      assert mention.author == "some updated author"
      assert mention.created_at == "Sat Dec 01 10:55:00 +0000 2018"
      assert mention.retweet_count == 43
      assert mention.tw_id == 43
      assert mention.tw_text == "some updated tw_text"
    end

    test "update_mention/2 with invalid data returns error changeset" do
      mention = mention_fixture()
      assert {:error, %Ecto.Changeset{}} = Tweets.update_mention(mention, @invalid_attrs)
      assert mention == Tweets.get_mention!(mention.id)
    end

    test "delete_mention/1 deletes the mention" do
      mention = mention_fixture()
      assert {:ok, %Mention{}} = Tweets.delete_mention(mention)
      assert_raise Ecto.NoResultsError, fn -> Tweets.get_mention!(mention.id) end
    end

    test "change_mention/1 returns a mention changeset" do
      mention = mention_fixture()
      assert %Ecto.Changeset{} = Tweets.change_mention(mention)
    end

    test "fetch_and_save/0 fetches recent mention from api and save it" do
      expect(TwitterMock, :fetch_recent_mention, fn attrs ->
        send(self(), {:fetch_recent_mention, attrs})
        {:ok, @valid_attrs}
      end)


      assert {:ok, %Mention{
        author: "some author",
        created_at: "Sat Dec 01 07:55:00 +0000 2018",
        retweet_count: 42,
        tw_id: 42,
        tw_text: "some tw_text"
      }} = Tweets.fetch_and_save()

      assert_received {:fetch_recent_mention, [screen_name: "Skoda091", count: 1]}
    end
  end
end
