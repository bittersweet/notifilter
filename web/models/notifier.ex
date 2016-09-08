defmodule Notifilter.Notifier do
  @moduledoc false

  use Ecto.Model

  @derive {Poison.Encoder, except: [:__meta__]}

  schema "notifiers" do
    field :application, :string
    field :event_name, :string
    field :template, :string
    field :rules, {:array, :map}, default: []
    field :notification_type, :string
    field :target, :string

    # timestamps(inserted_at: :created_at)
  end

  @required_fields ~w(application event_name template rules notification_type target)
  @optional_fields ~w()
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
