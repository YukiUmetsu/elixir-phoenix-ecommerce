defmodule Mango.CRM.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mango.CRM.Customer

  schema "customers" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :phone, :string
    field :residence_area, :string
    timestamps()
  end

  @doc false
  def changeset(%Customer{} = customer, attrs) do
    customer
    |> cast(attrs, [:name, :email, :phone, :residence_area, :password_hash])
    |> validate_required([:name, :email, :phone, :residence_area, :password_hash])
    |> unique_constraint(:email)
  end
end