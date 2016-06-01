defmodule Notifilter.Repo.Migrations.CreateNotifiers do
  use Ecto.Migration

  def change do
    create table(:notifiers) do
      add :application, :string
      add :event_name, :string
      add :template, :text
      add :rules, :json
      add :notification_type, :string
      add :target, :string
    end

    create index(:notifiers, [:event_name])
  end
end
