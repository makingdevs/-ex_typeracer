defmodule KeyboardHeroes.Mail.Email do
  import Bamboo.Email
  import Bamboo.Phoenix

  def send_email_register(person) do
    base_email()
    |> to(person.email)
    |> subject("Welcome hero!!!")
    |> put_header("Reply-To", "someone@example.com")
    |> html_body("<strong>Welcome #{person.username} !!!</strong><br/>Thanks for join us! http://keyboardheroes.io")
  end

  def send_email_recovery(email, token, username) do
    base_email()
    |> to(email)
    |> subject("Restore your password")
    |> html_body("<strong>Please use the following link: #{Application.get_env(:keyboard_heroes, KeyboardHeroesWeb.Endpoint)[:base_url]}recovery/#{token}/#{username}</strong><br/><strong>Username: #{username}</strong>")
  end

  defp base_email do
    new_email()
    |> from("info@makingdevs.com")
		|> put_header("Reply-To", "info@makingdevs.com")
    |> put_html_layout({KeyboardHeroes.LayoutView, "email.html"})
    |> put_text_layout({KeyboardHeroes.LayoutView, "email.text"})
  end

end
