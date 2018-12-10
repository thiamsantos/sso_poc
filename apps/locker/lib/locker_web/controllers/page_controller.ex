defmodule LockerWeb.PageController do
  use LockerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
