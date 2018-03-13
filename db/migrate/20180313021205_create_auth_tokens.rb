class CreateAuthTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.string :refresh_token
      t.datetime :expired_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
