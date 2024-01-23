defmodule Auction.Item do
  use Ecto.Schema
  import Ecto.Changeset

  def changeset(item, params \\ %{}) do
    item
    |> cast(params, [:title, :description, :ends_at])
    |> validate_required(:title)
    |> validate_length(:title, min: 3, max: 200)
    |> validate_length(:description, min: 3, max: 200)
    |> validate_change(:ends_at, &validate_date/2)
  end

  defp validate_date(:ends_at, ends_at_date) do
    case DateTime.compare(ends_at_date, DateTime.utc_now()) do
      :lt ->
        [ends_at: "ends_at cannot be in the past"]

      _ ->
        []
    end
  end

  @items [
    %{
      id: 1,
      title: "item1",
      description: "item1_descr",
      ends_at: DateTime.from_naive!(~N[2024-01-24 00:00:00], "Etc/UTC")
    },
    %{
      id: 2,
      title: "item2",
      description: "item2_descr",
      ends_at: DateTime.from_naive!(~N[2024-01-25 00:00:00], "Etc/UTC")
    },
    %{
      id: 3,
      title: "item3",
      description: "item3_descr",
      ends_at: DateTime.from_naive!(~N[2024-01-26 00:00:00], "Etc/UTC")
    }
  ]

  def items() do
    @items
  end

  schema "items" do
    field(:title, :string)
    field(:description, :string)
    field(:ends_at, :utc_datetime)
    timestamps()
  end
end
