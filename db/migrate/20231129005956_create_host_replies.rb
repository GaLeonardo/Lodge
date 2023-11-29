class CreateHostReplies < ActiveRecord::Migration[7.1]
  def change
    create_table :host_replies do |t|
      t.string :reply
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
