class CreateClubhouseInvitations < ActiveRecord::Migration
  def change
    create_table :clubhouse_invitations, id: :uuid, default: "uuid_generate_v1()" do |t|
      t.uuid :organization_id, null: false
      t.string :email, null: false
      t.string :token, null: false
      t.boolean :admin, null: false, default: false

      t.timestamps null: false
    end

    add_foreign_key :clubhouse_invitations, :clubhouse_organizations, column: :organization_id, on_delete: :cascade

    add_index :clubhouse_invitations, :organization_id
    add_index :clubhouse_invitations, [:email, :organization_id], unique: true
    add_index :clubhouse_invitations, :token, unique: true
  end
end
