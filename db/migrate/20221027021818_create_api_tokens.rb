class CreateApiTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :api_tokens do |t|
      t.belongs_to :admin_user, index: true, foreign_key: true, null: false
      t.string :access_key, null: false
      t.string :secret_key, null: false
      t.string :refresh_token
      t.datetime :expire_at 
      t.timestamps
    end
  end
end
