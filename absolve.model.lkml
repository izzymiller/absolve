connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

#Datagroups and caching
datagroup: absolve_default_datagroup {
  max_cache_age: "5 hours"
  sql_trigger: SELECT 1 ;;
}

persist_with: absolve_default_datagroup


#Base explores
explore: order_items {
  label: "Order Items"
  view_name: order_items

  join: order_facts {
    view_label: "Orders"
    relationship: many_to_one
    sql_on: ${order_facts.order_id} = ${order_items.order_id} ;;
  }

  join: inventory_items {
    #Left Join only brings in items that have been sold as order_item
    type: full_outer
    relationship: one_to_one
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
  }

  join: users {
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }

  join: user_order_facts {
    view_label: "Users"
    relationship: many_to_one
    sql_on: ${user_order_facts.user_id} = ${order_items.user_id} ;;
  }

  join: products {
    relationship: many_to_one
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
  }

  join: repeat_purchase_facts {
    relationship: many_to_one
    type: full_outer
    sql_on: ${order_items.order_id} = ${repeat_purchase_facts.order_id} ;;
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${distribution_centers.id} = ${inventory_items.product_distribution_center_id};;
    relationship: many_to_one
  }
}

#Carbon Cruncher Explores

explore: co2 {
  label: "Carbon Cruncher"
  extends: [order_items]
  view_name: order_items

  join: carbon_cruncher {
    type: left_outer
    relationship: one_to_one
    sql_on: ${order_items.order_id} = ${carbon_cruncher.order_id} AND ${order_items.id} = ${carbon_cruncher.order_item_id} ;;
  }
}
