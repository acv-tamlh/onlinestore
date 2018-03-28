class AddReferenceProductsToProductgroups < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :productgroups, index: true
  end
end
