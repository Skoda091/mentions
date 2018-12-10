defmodule Mentions.Repo.Migrations.CreateMentions do
  use Ecto.Migration

  def change do
    create table(:mentions) do
      add :tw_id, :bigint
      add :author, :string
      add :retweet_count, :integer
      add :created_at, :string
      add :tw_text, :text

      timestamps()
    end

    create(unique_index(:mentions, [:tw_id]))
  end
end
