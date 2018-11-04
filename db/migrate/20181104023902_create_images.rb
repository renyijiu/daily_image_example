class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.date :record_on, null: false, comment: '日期'
      t.string :url, null: false, comment: '图片地址'

      t.index :record_on, unique: true
      t.timestamps
    end
  end
end
