class AddOwnerToEvaluation < ActiveRecord::Migration
  def change
    add_column :evaluations, :owner_evaluated, :boolean
    add_column :evaluations, :searcher_match_seen, :boolean
  end
end
