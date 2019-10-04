connection: "izzy_sandbox"

# include all the views
include: "offsets.view"

datagroup: offset_dg {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: offset_dg

explore: purchases {
  view_label: "Purchase Data"
  join: purchases__offset {
    view_label: "Offset Data"
    sql: LEFT JOIN UNNEST([${purchases.offset}]) as purchases__offset ;;
    relationship: one_to_one
  }
  join: purchases__offset__latlng {
    view_label: "Offset Data"
    sql: LEFT JOIN UNNEST([${purchases__offset.latlng}]) as purchases__offset__latlng ;;
    relationship: one_to_one
  }

  join: purchases__renewable_energy_certificate {
    view_label: "REC data"
    sql: LEFT JOIN UNNEST([${purchases.renewable_energy_certificate}]) as purchases__renewable_energy_certificate ;;
    relationship: one_to_one
  }

  join: purchases__renewable_energy_certificate__latlng {
    view_label: "REC data"
    sql: LEFT JOIN UNNEST([${purchases__renewable_energy_certificate.latlng}]) as purchases__renewable_energy_certificate__latlng ;;
    relationship: one_to_one
  }
}
