defmodule Codecasts.UserTest do
  use Codecasts.ModelCase

  alias Codecasts.User

  @valid_attrs %{bio: "some content", email: "some content", name: "some content", password_hash: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
