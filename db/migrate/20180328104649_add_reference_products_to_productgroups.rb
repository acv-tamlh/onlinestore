class AddReferenceProductsToProductgroups < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :productgroup, index: true
  end
end
