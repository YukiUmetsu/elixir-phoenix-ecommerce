defmodule Mango.CRM do
  alias Mango.Repo
  alias Mango.CRM.Customer
  require IEx

  def get_customer(id), do: Repo.get(Customer, id)

  def build_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
  end

  def create_customer(attrs) do
    attrs
    |> build_customer
    |> Repo.insert
  end

  def get_customer_by_email(email) do
    cond do
      Blankable.blank?(String.trim(email)) -> nil
      true ->
        Repo.get_by(Customer, email: email)
    end
  end

  def get_customer_by_credentials(%{"email"=> email, "password" => password}) do
    customer = get_customer_by_email(email)
    cond do
      customer && Comeonin.Bcrypt.checkpw(password, customer.password_hash) -> customer
      true ->
        :error
    end
  end

end