defmodule PhxIconsDemoWeb.PageController do
  use PhxIconsDemoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
