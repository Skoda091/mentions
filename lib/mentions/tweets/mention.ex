defmodule Mentions.Tweets.Mention do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mentions" do
    field(:author, :string)
    field(:created_at, :string)
    field(:retweet_count, :integer)
    field(:tw_id, :integer)
    field(:tw_text, :string)

    timestamps()
  end

  @doc false
  def changeset(mention, attrs) do
    mention
    |> cast(attrs, [:tw_id, :author, :retweet_count, :created_at, :tw_text])
    |> validate_required([:tw_id, :author, :retweet_count, :created_at, :tw_text])
    |> unique_constraint(:tw_id)
  end
end
