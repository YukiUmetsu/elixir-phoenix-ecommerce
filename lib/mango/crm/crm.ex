defmodule Mango.CRM do
  alias Mango.CRM.Customer
  alias Mango.Repo

  def build_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
  end

  def create_customer(attrs) do
    attrs
    |> build_customer
    |> Repo.insert
  end
end