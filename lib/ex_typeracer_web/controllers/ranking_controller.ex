
defmodule KeyboardHeroesWeb.RankingController do
  use KeyboardHeroesWeb, :controller
  alias KeyboardHeroes.Repo
  alias KeyboardHeroes.Person
  alias KeyboardHeroes.Logic.PersonRepo
  alias KeyboardHeroes.Logic.Scores
  alias KeyboardHeroes.Auth.Guardian
  plug Ueberauth

  def index(conn, _params) do
    changeset = PersonRepo.change_user(%Person{})
    maybe_user = Guardian.Plug.current_resource(conn)
    message = if maybe_user != nil do
      "Someone is logged in"
    else
      "Ya estas registrado ? "
    end
    conn
      |> put_flash(:info, message)
      |> render("ranking.html", changeset: changeset, action: page_path(conn, :login), maybe_user: maybe_user, list_scores: get_list_scores())
  end

  defp get_list_scores do
    Scores.get_all
  end
end
