class CreatePromotionUsages < ActiveRecord::Migration[6.1]
  def change
    create_table :promotion_usages do |t|
      t.references :promotion, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :discount

      t.timestamps
    end
  end
end
