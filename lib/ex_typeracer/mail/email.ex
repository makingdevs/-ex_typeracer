defmodule ExTyperacer.Mail.Email do
  import Bamboo.Email
  import Bamboo.Phoenix

  def welcome_email do
    new_email(
      to: "leovergara.dark@gmail.com",
      from: "brandon@makingdevs.com",
      subject: "Welcome to the app.",
      html_body: "<strong>Thanks for joining!</strong>",
      text_body: "Thanks for joining!"
    )
  end

  def send_email_register(email, password) do
    base_email
    |> to(email)
    |> subject("Welcome!!!")
    |> put_header("Reply-To", "someone@example.com")
    |> html_body("<strong>bienvenido esta es tu contraseña: #{password}</strong>")
    |> text_body("Welcome esta es tu contraseña: #{password}")
  end

  def send_email_recovery(email, token, username) do
    base_email
    |> to(email)
    |> subject("Recuperación de contraseña")
    |> put_header("Reply-To", "someone@example.com")
    |> html_body("<strong>Link para restaurar contraseña: #{ExTyperacerWeb.Endpoint.url}/recovery/#{token}/#{username}</strong>")
    |> text_body("Welcome esta es tu contraseña")
  end

  defp base_email do
    # Here you can set a default from, default headers, etc.
    new_email
    |> from("brandon@makingdevs.com")
    |> put_html_layout({ExTyperacer.LayoutView, "email.html"})
    |> put_text_layout({ExTyperacer.LayoutView, "email.text"})
  end

end