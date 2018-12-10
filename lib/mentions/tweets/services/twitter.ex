defmodule Mentions.Tweets.Services.Twitter do
  @callback fetch_recent_mention(map()) :: {:ok, map()} | {:error, String.t()}
end
