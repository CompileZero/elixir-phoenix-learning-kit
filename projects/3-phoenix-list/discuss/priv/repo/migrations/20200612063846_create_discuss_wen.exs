defmodule Discuss.Repo.Migrations.CreateDiscussWen do
  use Ecto.Migration

  def change do
    create table(:discuss_wen) do

      timestamps()
    end

  end
end
