connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

datagroup: absolve_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: absolve_default_datagroup


explore: carbon_cruncher {

  join: carbon_cruncher_items {
    fields: [carbon_cruncher.created_date,carbon_cruncher.created_month,carbon_cruncher_items.is_returned,carbon_cruncher_items.gross_margin,carbon_cruncher_items.total_gross_margin,carbon_cruncher_items.shipping_method,carbon_cruncher_items.shipping_time,carbon_cruncher_items.status]
    type: left_outer
    sql_on: ${carbon_cruncher_items.order_id} = ${carbon_cruncher.id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    fields: []
    type: full_outer
    relationship: one_to_one
    sql_on: ${inventory_items.id} = ${carbon_cruncher_items.inventory_item_id} ;;
  }

  join: users {
    fields: []
    relationship: many_to_one
    sql_on: ${carbon_cruncher_items.user_id} = ${users.id} ;;
  }

  join: products {
    fields: []
    relationship: many_to_one
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
  }

  join: distribution_centers {
    fields: []
    type: left_outer
    sql_on: ${distribution_centers.id} = ${inventory_items.product_distribution_center_id} ;;
    relationship: many_to_one
  }
}
