class DropIsVerbFromSubSections < ActiveRecord::Migration[6.0]
  def change
    remove_column :sub_sections, :is_verb, :boolean
  end
end
