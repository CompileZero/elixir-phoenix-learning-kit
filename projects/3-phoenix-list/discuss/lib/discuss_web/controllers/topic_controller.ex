defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Topic

  def new(conn, params) do
    struct = %Topic{}
    params = %{}
    changeset = Topic.changeset(%Topic{}, %{})
  end
end
