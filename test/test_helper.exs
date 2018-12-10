ExUnit.start()

Mox.defmock(Mentions.Tweets.Services.TwitterMock, for: Mentions.Tweets.Services.Twitter)
Application.put_env(:mentions, :twitter_api, Mentions.Tweets.Services.TwitterMock)

Ecto.Adapters.SQL.Sandbox.mode(Mentions.Repo, :manual)
