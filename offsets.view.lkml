view: purchases {
  sql_table_name: purchase_data.purchases ;;

  dimension: electricity_in_kwh {
    type: number
    sql: ${TABLE}.electricity_in_kwh ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }

  dimension: equivalent_carbon_in_kg {
    type: number
    sql: ${TABLE}.equivalent_carbon_in_kg ;;
  }

  dimension_group: estimated {
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
    sql: ${TABLE}.estimated_at ;;
  }

  dimension: micro_rec_count {
    type: number
    sql: ${TABLE}.micro_rec_count ;;
  }

  dimension: micro_units {
    type: number
    sql: ${TABLE}.micro_units ;;
  }

  dimension: offset {
    hidden: yes
    sql: ${TABLE}.offset ;;
  }

  dimension: pretty_url {
    type: string
    sql: ${TABLE}.pretty_url ;;
  }

  dimension_group: purchased {
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
    sql: ${TABLE}.purchased_at ;;
  }

  dimension: rec_cost_in_usd_cents {
    type: number
    sql: ${TABLE}.rec_cost_in_usd_cents ;;
  }

  dimension: renewable_energy_certificate {
    hidden: yes
    sql: ${TABLE}.renewable_energy_certificate ;;
  }

  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: total_cost_in_usd_cents {
    type: number
    sql: ${TABLE}.total_cost_in_usd_cents ;;
  }

  dimension: transaction_cost_in_usd_cents {
    type: number
    sql: ${TABLE}.transaction_cost_in_usd_cents ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: purchases__offset {
  dimension: available_carbon_in_kg {
    type: number
    sql: ${TABLE}.available_carbon_in_kg ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: latlng {
    hidden: yes
    sql: ${TABLE}.latlng ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: offset_type {
    type: string
    sql: ${TABLE}.offset_type ;;
  }

  dimension: pretty_url {
    type: string
    sql: ${TABLE}.pretty_url ;;
  }

  dimension: province {
    type: string
    sql: ${TABLE}.province ;;
  }

  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension: technical_details {
    type: string
    sql: ${TABLE}.technical_details ;;
  }

  dimension: total_capacity {
    type: string
    sql: ${TABLE}.total_capacity ;;
  }
}

view: purchases__offset__latlng {
  dimension: offset_location {
    type: location
    sql_latitude: ${x} ;;
    sql_longitude: ${y} ;;
  }
  dimension: x {
    type: number
    hidden: yes
    sql: ${TABLE}.x ;;
  }

  dimension: y {
    type: number
    hidden: yes
    sql: ${TABLE}.y ;;
  }
}

view: purchases__renewable_energy_certificate {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: latlng {
    hidden: yes
    sql: ${TABLE}.latlng ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: province {
    type: string
    sql: ${TABLE}.province ;;
  }

  dimension: renewable_type {
    type: string
    sql: ${TABLE}.renewable_type ;;
  }

  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension: technical_details {
    type: string
    sql: ${TABLE}.technical_details ;;
  }

  dimension: total_capacity {
    type: string
    sql: ${TABLE}.total_capacity ;;
  }
}

view: purchases__renewable_energy_certificate__latlng {
  dimension: x {
    type: number
    sql: ${TABLE}.x ;;
  }

  dimension: y {
    type: number
    sql: ${TABLE}.y ;;
  }
}
