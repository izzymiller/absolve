view: carbon_cruncher {

  derived_table: {
    sql: WITH order_item_facts AS (SELECT
    order_items.order_id  AS order_id,
    order_items.id  AS order_items_id,
    ((CASE WHEN distribution_centers.latitude  = users.latitude  AND distribution_centers.longitude  = users.longitude  THEN 0 ELSE ACOS(SIN((IFNULL(distribution_centers.latitude , 0.0) * 3.141592653589793 / 180)) * SIN((IFNULL(users.latitude , 0.0) * 3.141592653589793 / 180)) + COS((IFNULL(distribution_centers.latitude , 0.0) * 3.141592653589793 / 180)) * COS((IFNULL(users.latitude , 0.0) * 3.141592653589793 / 180)) * COS((IFNULL(users.longitude  - distribution_centers.longitude , 0.0) * 3.141592653589793 / 180))) * 6371 END) / 1.60934) AS order_items_ship_distance,
    order_items.ship_method  AS shipping_method,
    products.weight  AS products_weight,

    ((CASE WHEN distribution_centers.latitude  = users.latitude  AND distribution_centers.longitude  = users.longitude  THEN 0 ELSE ACOS(SIN((IFNULL(distribution_centers.latitude , 0.0) * 3.141592653589793 / 180)) * SIN((IFNULL(users.latitude , 0.0) * 3.141592653589793 / 180)) + COS((IFNULL(distribution_centers.latitude , 0.0) * 3.141592653589793 / 180)) * COS((IFNULL(users.latitude , 0.0) * 3.141592653589793 / 180)) * COS((IFNULL(users.longitude  - distribution_centers.longitude , 0.0) * 3.141592653589793 / 180))) * 6371 END) / 1.60934) * products.weight AS item_lbs_mi,
    (
    ((CASE WHEN distribution_centers.latitude  = users.latitude  AND distribution_centers.longitude  = users.longitude  THEN 0 ELSE ACOS(SIN((IFNULL(distribution_centers.latitude , 0.0) * 3.141592653589793 / 180)) * SIN((IFNULL(users.latitude , 0.0) * 3.141592653589793 / 180)) + COS((IFNULL(distribution_centers.latitude , 0.0) * 3.141592653589793 / 180)) * COS((IFNULL(users.latitude , 0.0) * 3.141592653589793 / 180)) * COS((IFNULL(users.longitude  - distribution_centers.longitude , 0.0) * 3.141592653589793 / 180))) * 6371 END) / 1.60934) * products.weight
    ) *
  CASE WHEN order_items.ship_method = 'air' THEN 1.23205
  WHEN order_items.ship_method = 'truck' THEN 0.11360
  WHEN order_items.ship_method = 'boat' THEN 0.01614
  ELSE null
  END AS carbon_footprint
  FROM absolve.order_items  AS order_items
  FULL OUTER JOIN absolve.inventory_items  AS inventory_items ON inventory_items.id = order_items.inventory_item_id
  LEFT JOIN absolve.users  AS users ON order_items.user_id = users.id
  LEFT JOIN absolve.products  AS products ON products.id = inventory_items.product_id
  LEFT JOIN absolve.distribution_centers  AS distribution_centers ON distribution_centers.id = inventory_items.product_distribution_center_id)

  SELECT order_item_facts.order_id AS order_id, order_item_facts.order_items_id AS order_items_id, order_item_facts.shipping_method AS shipping_method,order_item_facts.carbon_footprint AS carbon_footprint ,order_item_facts.item_lbs_mi AS item_lbs_mi,
  SUM(order_item_facts.item_lbs_mi) AS total_order_lbs_mi,SUM(order_item_facts.carbon_footprint) AS total_order_footprint
  FROM order_item_facts
  GROUP BY 1,2,3,4,5

 ;;

datagroup_trigger: absolve_default_datagroup
  }

dimension: order_id {
  type: number
  sql: ${TABLE}.order_id ;;
}

dimension: order_item_id {
  type: number
  sql: ${TABLE}.order_items_id
  ;;
}

dimension: shipping_method {
  type: string
  sql: ${TABLE}.shipping_method ;;
}

dimension: order_level_lbs_mi {
  type: number
  sql: ${TABLE}.total_order_lbs_mi ;;
}
  dimension: order_level_footprint {
    type: number
    sql: ${TABLE}.total_order_footprint ;;
  }

measure: total_lbs_mi {
  type: sum
  sql: ${TABLE}.item_lbs_mi ;;
}

measure: carbon_footprint {
  label: "CO2e Footprint (kg)"
  type: sum
  sql: ${TABLE}.carbon_footprint;;
  tags: ["co2_footprint"]
}

# measure: carbon_footprint {
#   type: number
#   label: "CO2e Footprint (kg)"
#   sql:
#   ${total_lbs_mi}*
#   CASE WHEN ${shipping_method} = 'air' THEN 1.23205
#   WHEN ${shipping_method} = 'truck' THEN 0.11360
#   WHEN ${shipping_method} = 'boat' THEN 0.01614
#   ELSE null
#   END;;
#   tags: ["co2_footprint"]
# }


}
