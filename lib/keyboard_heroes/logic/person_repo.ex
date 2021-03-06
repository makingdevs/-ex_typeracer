defmodule KeyboardHeroes.Logic.PersonRepo do

  alias KeyboardHeroes.Repo
  alias KeyboardHeroes.Person
  import Ecto.Query, only: [from: 2]
  alias Comeonin.Bcrypt
  alias KeyboardHeroes.Mail.Email
  alias KeyboardHeroes.Mail.Mailer

  def save_person(person) do
    changeset = Person.changeset( %Person{}, Map.from_struct(person))
    case changeset.valid? do
      true -> Repo.insert changeset
      false -> changeset.errors
    end
  end

  def update_person(person, password) do
    changeset = Person.changeset( person, %{ password: password})
    Repo.update changeset
  end

  def send_email_register({:ok, person}) do
    Email.send_email_register(person) |> Mailer.deliver_now
    person.username
  end

  def send_email_token_recovery(person) do
    token = Phoenix.Token.sign(KeyboardHeroesWeb.Endpoint, person.username, person.id)
    Email.send_email_recovery(person.email, token, person.username) |> Mailer.deliver_now
  end

  def find_user_by_username(username) do
    query = from u in Person, where: u.username == ^username, select: u
    Repo.all(query)
    |> List.first
  end

  def find_user_by_email(email) do
    query = from u in Person, where: u.email == ^email, select: u
    Repo.all(query)
    |> List.first
  end

  def find_user_by_id(id) do
    person = Repo.get Person, id
    case person do
      nil -> {:not, ""}
      _ -> {:ok, person}
    end
  end

  def check_password(nil, _), do: {:error, "Incorrect username or password"}

  def check_password(person, password) do
    case Bcrypt.checkpw(password, person.password) do
      true -> {:ok, person}
      false -> {:error, "Incorrect username or password"}
    end
  end

  def get_user!(id), do: Repo.get!(Person, id)

  def list_users do
    Repo.all(Person)
  end

  def change_user(%Person{} = user) do
    Person.changeset(user, %{})
  end

  def authenticate_user(username, password)do
    find_user_by_username(username)
    |> check_password(password)
  end

end
