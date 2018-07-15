defmodule KeyboardHeroes.Logic.Scores do

  alias KeyboardHeroes.Repo
  alias KeyboardHeroes.Score
  import Ecto.Query, only: [from: 2]

  def save_score(score) do
    changeset = Score.changeset( %Score{}, Map.from_struct(score))
    case changeset.valid? do
      true -> Repo.insert changeset
      false -> changeset.errors
    end
  end

  def get_all do
    Repo.all Score
  end


end