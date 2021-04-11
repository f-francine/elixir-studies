defmodule PaymentsApi.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :nickname, :string
      add :age, :integer
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:nickname])
    create unique_index(:users, [:email])
  end
end
