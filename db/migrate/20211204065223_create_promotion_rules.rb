class CreatePromotionRules < ActiveRecord::Migration[6.1]
  def change
    create_table :promotion_rules do |t|
      t.references :promotion, null: false, foreign_key: true
      t.string :type
      t.jsonb :config

      t.timestamps
    end
  end
end
