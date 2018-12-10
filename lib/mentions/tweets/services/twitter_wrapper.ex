defmodule Mentions.Tweets.Services.TwitterWrapper do
  @behaviour Mentions.Tweets.Services.Twitter
  @moduledoc """
  Implementation for handling twitter API behaviour.
  """

  @doc """
  Fetch mentions for provided username.
  """
  @impl true
  def fetch_recent_mention(attrs \\ []) do
    result =
      attrs
      |> ExTwitter.user_timeline()
      |> parse_response()

    {:ok, result}
  end

  defp parse_response([
         %{
           id: id,
           retweet_count: retweet_count,
           text: text,
           entities: _entities,
           user: %{screen_name: screen_name},
           created_at: created_at
         }
         | _
       ]) do
    %{
      author: screen_name,
      retweet_count: retweet_count,
      created_at: created_at,
      tw_id: id,
      tw_text: text
    }
  end
end
