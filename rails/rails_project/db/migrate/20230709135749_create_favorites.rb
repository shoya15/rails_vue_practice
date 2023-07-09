class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
      # 同一ユーザーが複数回いいねできないようにする(表示を切り替えれば不要な気もするが一応)
      t.index [:user_id, :task_id], unique: true
    end
  end
end
