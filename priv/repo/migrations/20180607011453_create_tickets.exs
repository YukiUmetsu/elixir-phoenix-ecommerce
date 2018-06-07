defmodule Mango.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :subject, :string
      add :message, :string
      add :status, :string
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps()
    end

    create index(:tickets, [:customer_id])
  end
end
