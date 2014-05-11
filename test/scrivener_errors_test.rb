require_relative "../lib/scrivener_errors"
require "scrivener"

class SignUp < Scrivener
  attr_accessor :email, :password, :password_confirmation

  def validate
    assert_email :email

    if assert_present :password
      assert_length :password, (8..99)
      assert(password == password_confirmation,
             [:password_confirmation, :not_confirmed])

      assert_format :password, /^[\S]+/
    end
  end
end

scope do
  test "error messages" do
    filter = SignUp.new(email: 'john',
                        password: 'password',
                        password_confirmation: 'p4ssw3rd')

    messages = ScrivenerErrors.new(filter).messages
    assert_equal "email is not an email", messages[0]
    assert_equal "password confirmation is invalid", messages[1]
  end

  test "multiple errors on a single attribute" do
    filter = SignUp.new(email: 'john@example.com',
                        password: 'x',
                        password_confirmation: 'y')

    messages = ScrivenerErrors.new(filter).messages
    assert_equal "password has invalid length", messages[0]
    assert_equal "password confirmation is invalid", messages[1]
  end

  test "no errors" do
    filter = SignUp.new(email: 'john@example.com',
                        password: 'password',
                        password_confirmation: 'password')

    messages = ScrivenerErrors.new(filter).messages
    assert_equal [], messages
  end

  test "converting to a string" do
    filter = SignUp.new(email: 'john',
                        password: 'password',
                        password_confirmation: 'y')

    assert_equal(
      "Email is not an email, password confirmation is invalid",
      ScrivenerErrors.new(filter).message
    )
  end

  test "an error string for a single attribute" do
    filter = SignUp.new(email: 'john',
                        password: ' x',
                        password_confirmation: 'y')

    assert_equal(
      "is not an email",
      ScrivenerErrors.new(filter)[:email])

    assert_equal(
      "has invalid length, is invalid",
      ScrivenerErrors.new(filter)[:password])
  end
end

scope do
  test "filter errors to a string" do
    object = Object.new
    object.extend ScrivenerErrors::Helpers

    filter = SignUp.new(email: 'john',
                        password: 'password',
                        password_confirmation: 'y')

    assert_equal(
      "Email is not an email, password confirmation is invalid",
      object.filter_error(filter)
    )
  end
end
