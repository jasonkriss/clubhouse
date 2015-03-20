class CreateClubhouseMemberships < ActiveRecord::Migration
  def change
    create_table :clubhouse_memberships, id: :uuid, default: "uuid_generate_v1()" do |t|
      t.uuid :member_id, null: false
      t.uuid :organization_id, null: false
      t.boolean :admin, null: false, default: false

      t.timestamps null: false
    end

    add_foreign_key :clubhouse_memberships, :users, column: :member_id, on_delete: :cascade
    add_foreign_key :clubhouse_memberships, :clubhouse_organizations, column: :organization_id, on_delete: :cascade

    add_index :clubhouse_memberships, :member_id
    add_index :clubhouse_memberships, :organization_id
    add_index :clubhouse_memberships, [:member_id, :organization_id], unique: true
  end
end
