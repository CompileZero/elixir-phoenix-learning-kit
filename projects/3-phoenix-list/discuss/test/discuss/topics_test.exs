defmodule Discuss.TopicsTest do
  use Discuss.DataCase

  alias Discuss.Topics

  describe "string" do
    alias Discuss.Topics.Title

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def title_fixture(attrs \\ %{}) do
      {:ok, title} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Topics.create_title()

      title
    end

    test "list_string/0 returns all string" do
      title = title_fixture()
      assert Topics.list_string() == [title]
    end

    test "get_title!/1 returns the title with given id" do
      title = title_fixture()
      assert Topics.get_title!(title.id) == title
    end

    test "create_title/1 with valid data creates a title" do
      assert {:ok, %Title{} = title} = Topics.create_title(@valid_attrs)
    end

    test "create_title/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topics.create_title(@invalid_attrs)
    end

    test "update_title/2 with valid data updates the title" do
      title = title_fixture()
      assert {:ok, %Title{} = title} = Topics.update_title(title, @update_attrs)
    end

    test "update_title/2 with invalid data returns error changeset" do
      title = title_fixture()
      assert {:error, %Ecto.Changeset{}} = Topics.update_title(title, @invalid_attrs)
      assert title == Topics.get_title!(title.id)
    end

    test "delete_title/1 deletes the title" do
      title = title_fixture()
      assert {:ok, %Title{}} = Topics.delete_title(title)
      assert_raise Ecto.NoResultsError, fn -> Topics.get_title!(title.id) end
    end

    test "change_title/1 returns a title changeset" do
      title = title_fixture()
      assert %Ecto.Changeset{} = Topics.change_title(title)
    end
  end
end
