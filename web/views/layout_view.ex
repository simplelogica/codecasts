defmodule Codecasts.LayoutView do
  use Codecasts.Web, :view
  import Phoenix.Controller, only: [get_flash: 1]

  # Function to show flash messages using bootstrap classes
  def show_flash(conn) do
    get_flash(conn) |> flash_msg
  end

  def flash_msg(%{"info" => msg}) do
    ~E"<div class='alert alert-info'><%= msg %></div>"
  end

  def flash_msg(%{"error" => msg}) do
    ~E"<div class='alert alert-danger'><%= msg %></div>"
  end

  def flash_msg(_) do
    nil
  end
end
