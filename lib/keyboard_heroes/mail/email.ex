defmodule KeyboardHeroes.Mail.Email do
  use Bamboo.Phoenix, view: KeyboardHeroesWeb.EmailView
  

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
    |> put_html_layout({KeyboardHeroesWeb.LayoutView, "email.html"})
    |> put_text_layout({KeyboardHeroesWeb.LayoutView, "email.text"})
  end

  def send_sample_email(email) do
    base_email()
    |> to(email)
    |> subject("Welcome hero!!!")
    |> put_header("Reply-To", "someone@example.com")
    |> html_body("<strong>Welcome  !!!</strong><br/>Thanks for join us! http://keyboardheroes.io")
    |> render("send_register.html")
  end

end
