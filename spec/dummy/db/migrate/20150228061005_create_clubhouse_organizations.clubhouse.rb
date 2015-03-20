# This migration comes from clubhouse (originally 20150226023025)
class CreateClubhouseOrganizations < ActiveRecord::Migration
  def change
    create_table :clubhouse_organizations, id: :uuid, default: "uuid_generate_v1()" do |t|
      t.string :name, null: false, limit: 30
      t.string :email, null: false

      t.timestamps null: false
    end

    add_index :clubhouse_organizations, :name, unique: true
  end
end
