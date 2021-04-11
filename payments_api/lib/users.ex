defmodule PaymentsApi.Users do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:name, :email, :nickname, :age, :password]

  schema "users" do
    field :name, :string
    field :email, :string
    field :nickname, :string
    field :age, :integer
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 8)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> unique_constraint(:nickname)
    |> unique_constraint(:email)
    |> encode_password()

  end

  defp encode_password(%{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end
end
