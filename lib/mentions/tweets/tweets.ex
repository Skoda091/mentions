defmodule Mentions.Tweets do
  @moduledoc """
  The Tweets context.
  """

  import Ecto.Query, warn: false
  alias Mentions.Repo

  alias Mentions.Tweets.Mention
  alias Mentions.Tweets.Services.TwitterWrapper

  @doc """
  Returns the list of mentions.

  ## Examples

      iex> list_mentions()
      [%Mention{}, ...]

  """
  def list_mentions do
    Repo.all(Mention)
  end

  @doc """
  Returns the list of mentions from API.

  ## Examples

      iex> fetch_recent_mention()
      [%Mention{}, ...] ???

  """
  def fetch_recent_mention(attrs) do
    case twitter_api().fetch_recent_mention(attrs) do
      {:ok, result} -> result
      {:error, message} -> {:error, message}
    end
  end

  @doc """
  Gets a single mention.

  Raises `Ecto.NoResultsError` if the Mention does not exist.

  ## Examples

      iex> get_mention!(123)
      %Mention{}

      iex> get_mention!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mention!(id), do: Repo.get!(Mention, id)

  @doc """
  Creates a mention.

  ## Examples

      iex> create_mention(%{field: value})
      {:ok, %Mention{}}

      iex> create_mention(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mention(attrs \\ %{}) do
    %Mention{}
    |> Mention.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mention.

  ## Examples

      iex> update_mention(mention, %{field: new_value})
      {:ok, %Mention{}}

      iex> update_mention(mention, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mention(%Mention{} = mention, attrs) do
    mention
    |> Mention.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Mention.

  ## Examples

      iex> delete_mention(mention)
      {:ok, %Mention{}}

      iex> delete_mention(mention)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mention(%Mention{} = mention) do
    Repo.delete(mention)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mention changes.

  ## Examples

      iex> change_mention(mention)
      %Ecto.Changeset{source: %Mention{}}

  """
  def change_mention(%Mention{} = mention) do
    Mention.changeset(mention, %{})
  end

  @doc """
  Fetches mention from API and saves it in database.

  ## Examples

      iex> fetch_and_save(%{field: value})
      {:ok, %Mention{}}

      iex> fetch_and_save(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def fetch_and_save() do
    [screen_name: Application.get_env(:mentions, :screen_name), count: 1]
    |> fetch_recent_mention()
    |> create_mention()
  end

  defp twitter_api(), do: Application.get_env(:mentions, :twitter_api, TwitterWrapper)
end
