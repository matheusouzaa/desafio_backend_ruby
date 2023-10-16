class ChangeStatusToIntegerInMunicipes < ActiveRecord::Migration[7.1]
  class ChangeStatusToIntegerInMunicipes < ActiveRecord::Migration[7.1]
    def up
      change_table :municipes do |t|
        t.remove :status
        t.integer :status, default: 0
      end

      Municipe.update_all(status: 1)
    end

    def down
      change_table :municipes do |t|
        t.remove :status
        t.boolean :status
      end
    end
  end
end