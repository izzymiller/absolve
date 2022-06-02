include: "absolve.model.lkml"
view: order_facts {
  derived_table: {
    explore_source: order_items {
      column: order_id {}
      column: items_in_order { field: order_items.count }
      column: order_amount { field: order_items.total_sale_price }
      column: order_cost { field: inventory_items.total_cost }
      column: user_id {field: order_items.user_id }
      column: created_at {field: order_items.created_raw}
      column: order_gross_margin {field: order_items.total_gross_margin}
      # column: average_sale_price {field: order_items.average_sale_price}

      derived_column: order_sequence_number {
        sql: RANK() OVER (PARTITION BY user_id ORDER BY created_at) ;;
      }
    }
    datagroup_trigger: absolve_default_datagroup
  }
  # `jn`

  dimension: order_id {
    type: number
    hidden: no
    primary_key: yes
    sql: ${TABLE}.order_id ;;
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

  dimension: items_in_order {
    type: number
    sql: ${TABLE}.items_in_order ;;
  }

  dimension: order_amount {
    type: number
    value_format_name: usd
    sql: ${TABLE}.order_amount ;;
  }

  dimension: order_cost {
    type: number
    value_format_name: usd
    sql: ${TABLE}.order_cost ;;
  }

  dimension: order_gross_margin {
    type: number
    value_format_name: usd
  }


  dimension: order_sequence_number {
    type: number
    sql: ${TABLE}.order_sequence_number ;;
  }

  dimension: is_first_purchase {
    type: yesno
    sql: ${order_sequence_number} = 1 ;;
  }

  # dimension: average_sale_price {
  #   type: average
  #   value_format_name: usd
  #   sql: ${sale_price} ;;
  #   drill_fields: [detail*]
  # }

  # measure: median_sale_price {
  #     type: median
  #     value_format_name: usd
  #     sql: ${average_sale_price} ;;
  #     drill_fields: [detail*]
  #   }


}
