
defmodule KeyboardHeroes.Email.EmailTest do
  use ExUnit.Case

  alias KeyboardHeroes.Mail.Email
  alias KeyboardHeroes.Mail.Mailer

  test "send a email from amazon stp" do
    IO.puts "Holta test"
    resul = Email.send_sample_email("brandon@makingdevs.com") |> Mailer.deliver_now
    IO.inspect resul
    assert true
  end
end