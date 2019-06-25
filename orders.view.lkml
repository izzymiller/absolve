view: orders {
  sql_table_name: absolve.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.id, users.first_name, order_items.count]
  }

  measure: total_ship_distance {
    type: sum_distinct
    sql: ${order_items.ship_distance} ;;
  }

  measure: carbon_footprint {
    type: number
    label: "CO2e Footprint (kg)"
    sql:
    (${total_ship_distance}*${products.total_weight})*
    CASE WHEN ${order_items.shipping_method} = 'air' THEN 1.23205
    WHEN ${order_items.shipping_method} = 'truck' THEN 0.11360
    WHEN ${order_items.shipping_method} = 'boat' THEN 0.01614
    ELSE null
    END;;
    tags: ["co2_footprint"]
  }
}
