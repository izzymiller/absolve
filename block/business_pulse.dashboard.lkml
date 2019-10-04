- dashboard: business_pulse_with_carbon
  title: Business Pulse With Carbon
  layout: newspaper
  description: ''
  embed_style:
    background_color: ''
    show_title: true
    title_color: "#3a4245"
    show_filters_bar: false
    tile_text_color: "#3a4245"
    text_tile_text_color: "#636061"
  elements:
  - title: Number of First Purchasers
    name: Number of First Purchasers
    model: absolve
    explore: order_items
    type: single_value
    fields: [order_items.first_purchase_count]
    sorts: [order_items.first_purchase_count desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: goal, label: Goal, expression: '20000', value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: dimension, _type_hint: number}]
    query_timezone: America/Los_Angeles
    font_size: medium
    colors: ["#5245ed", "#a2dcf3", "#776fdf", "#1ea8df", "#49cec1", "#776fdf", "#49cec1",
      "#1ea8df", "#a2dcf3", "#776fdf", "#776fdf", "#635189"]
    text_color: black
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: New Users Acquired
    custom_color_enabled: true
    custom_color: "#8dd3c7"
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: above
    note_text: ''
    listen:
      Date: order_items.created_date
      State: users.state
      City: users.city
      User ID: users.id
    row: 2
    col: 0
    width: 6
    height: 4
  - title: Average Order Sale Price
    name: Average Order Sale Price
    model: absolve
    explore: order_items
    type: single_value
    fields: [order_items.average_sale_price]
    sorts: [orders.average_profit desc, order_items.average_sale_price desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: date, label: date, expression: now(), value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: "#8dd3c7"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    font_size: medium
    text_color: black
    colors: ["#5245ed", "#a2dcf3", "#776fdf", "#1ea8df", "#49cec1", "#776fdf", "#49cec1",
      "#1ea8df", "#a2dcf3", "#776fdf", "#776fdf", "#635189"]
    series_types: {}
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: below
    note_text: ''
    listen:
      Date: order_items.created_date
      State: users.state
      City: users.city
    row: 2
    col: 6
    width: 6
    height: 4
  - title: Orders by Day and Category
    name: Orders by Day and Category
    model: absolve
    explore: order_items
    type: looker_area
    fields: [products.category, order_items.count, order_items.created_date]
    pivots: [products.category]
    fill_fields: [order_items.created_date]
    filters:
      products.category: Blazers & Jackets,Sweaters,Pants,Shorts,Fashion Hoodies &
        Sweatshirts,Accessories
    sorts: [products.category, order_items.created_date desc]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    colors: ['palette: Mixed Pastels']
    y_axis_labels: ["# Order Items"]
    stacking: normal
    x_axis_datetime: true
    hide_points: true
    hide_legend: false
    x_axis_datetime_tick_count: 4
    show_x_axis_label: false
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: monotone
    limit_displayed_rows: false
    y_axis_scale_mode: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_colors: {}
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: below
    note_text: ''
    listen:
      Date: order_items.created_date
      State: users.state
      City: users.city
    row: 15
    col: 0
    width: 24
    height: 8
  - title: Highest Spending Users
    name: Highest Spending Users
    model: absolve
    explore: order_items
    type: looker_map
    fields: [users.approx_location, users.gender, order_items.order_count, users.count,
      order_items.total_sale_price, order_items.average_spend_per_user, users.country]
    pivots: [users.gender]
    filters:
      users.country: USA
    sorts: [users.gender 0, order_items.total_sale_price desc 0]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 37.85100126460795
    map_longitude: -97.85213470458986
    map_zoom: 4
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: value
    map_marker_color: ["#8dd3c7", "#ffed6f", "#bebada", "#fb8072", "#80b1d3"]
    show_view_names: false
    show_legend: true
    map_value_colors: [white, purple]
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_value_scale_clamp_min: 0
    map_value_scale_clamp_max: 200
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    loading: false
    hidden_fields: [orders.count, users.count, order_items.total_sale_price, order_items.order_count,
      users.country]
    map: usa
    map_projection: ''
    quantize_colors: false
    colors: [whitesmoke, "#64518A"]
    outer_border_color: "#64518A"
    inner_border_color: ''
    inner_border_width: 0.6
    outer_border_width: 2
    empty_color: ''
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Bubble size corresponds to average user spend
    listen:
      Date: order_facts.created_date
      State: users.state
      City: users.city
    row: 6
    col: 12
    width: 12
    height: 9
  - title: Total Order Count
    name: Total Order Count
    model: absolve
    explore: order_items
    type: single_value
    fields: [order_items.reporting_period, order_items.count]
    filters:
      order_items.reporting_period: "-NULL"
    sorts: [order_items.count desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: percent_change, label: Percent Change, expression: "${order_items.count}/offset(${order_items.count},1)\
          \ - 1", value_format: !!null '', value_format_name: percent_0}]
    query_timezone: America/Los_Angeles
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    colors: ["#5245ed", "#a2dcf3", "#776fdf", "#1ea8df", "#49cec1", "#776fdf", "#49cec1",
      "#1ea8df", "#a2dcf3", "#776fdf", "#776fdf", "#635189"]
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_single_value_title: true
    single_value_title: Orders This Year
    hidden_fields: [order_items.reporting_period]
    comparison_label: vs Same Period Last Year
    custom_color_enabled: true
    custom_color: "#8dd3c7"
    y_axes: []
    listen:
      State: users.state
      City: users.city
    row: 2
    col: 18
    width: 6
    height: 4
  - name: <img src="https://www.evernote.com/l/An-33sEcBGpNvb1WgHli1n19veaZWW4Vep4B/image.png"
      width="476" height="80"/>
    type: text
    title_text: <img src="https://www.evernote.com/l/An-33sEcBGpNvb1WgHli1n19veaZWW4Vep4B/image.png"
      width="476" height="80"/>
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - title: kg Co₂e emitted
    name: kg Co₂e emitted
    model: absolve
    explore: co2
    type: single_value
    fields: [carbon_cruncher.carbon_footprint_with_tgm]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: 'concat(round(${carbon_cruncher.carbon_footprint}/1000000,2),"
          M")', value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: string, is_disabled: true}]
    custom_color_enabled: true
    custom_color: "#8dd3c7"
    show_single_value_title: true
    value_format: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields:
    listen:
      Date: order_facts.created_date
    row: 28
    col: 0
    width: 12
    height: 4
  - title: Monthly CO₂e/Margin
    name: Monthly CO₂e/Margin
    model: absolve
    explore: co2
    type: looker_column
    fields: [order_items.created_month, order_items.total_gross_margin, carbon_cruncher.carbon_footprint_with_tgm]
    filters:
      order_items.created_month: 36 months
    sorts: [order_items.created_month]
    limit: 500
    column_limit: 50
    color_application:
      collection_id: legacy
      palette_id: mixed_pastels
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: carbon_cruncher.carbon_footprint,
            id: carbon_cruncher.carbon_footprint, name: CO2e Footprint (kg)}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: order_items.total_gross_margin,
            id: order_items.total_gross_margin, name: Total Gross Margin}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      order_items.total_gross_margin: "#ffed6f"
      carbon_cruncher.carbon_footprint_with_tgm: "#8dd3c7"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    column_group_spacing_ratio: 0
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 49
    col: 6
    width: 12
    height: 9
  - name: Co2 Footprint / Offset
    title: Co2 Footprint / Offset
    merged_queries:
    - model: offsets
      explore: purchases
      type: looker_column
      fields: [purchases.total_carbon_offset, purchases.total_cost_in_usd, purchases.purchased_week]
      fill_fields: [purchases.purchased_week]
      sorts: [purchases.purchased_week desc]
      limit: 500
      query_timezone: America/Los_Angeles
      color_application:
        collection_id: legacy
        palette_id: mixed_pastels
        options:
          steps: 5
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      plot_size_by_field: false
      trellis: ''
      stacking: ''
      limit_displayed_rows: false
      legend_position: center
      series_types: {}
      point_style: none
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      hidden_fields: [purchases.total_cost_in_usd]
      join_fields: []
    - model: absolve
      explore: co2
      type: looker_line
      fields: [order_items.created_week, carbon_cruncher.carbon_footprint_backend]
      fill_fields: [order_items.created_week]
      filters:
        order_items.created_week: 6 weeks
      sorts: [order_items.created_week desc]
      limit: 500
      query_timezone: America/Los_Angeles
      color_application:
        collection_id: legacy
        palette_id: mixed_pastels
        options:
          steps: 5
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      plot_size_by_field: false
      trellis: ''
      stacking: ''
      limit_displayed_rows: false
      legend_position: center
      point_style: none
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      hidden_fields: []
      join_fields:
      - field_name: order_items.created_week
        source_field_name: purchases.purchased_week
    color_application:
      collection_id: legacy
      palette_id: mixed_pastels
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: purchases.total_carbon_offset,
            id: purchases.total_carbon_offset, name: Total Co2 offset (kg)}, {axisId: carbon_cruncher.carbon_footprint,
            id: carbon_cruncher.carbon_footprint, name: CO2e Footprint (kg)}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    type: looker_column
    hidden_fields: [purchases.total_cost_in_usd]
    listen:
    - Date: purchases.purchased_date
    - Date: order_facts.created_date
    row: 36
    col: 0
    width: 12
    height: 7
  - name: Gross Margin vs. Offset Spend
    title: Gross Margin vs. Offset Spend
    merged_queries:
    - model: offsets
      explore: purchases
      type: looker_column
      fields: [purchases.total_cost_in_usd, purchases.purchased_week]
      fill_fields: [purchases.purchased_week]
      sorts: [purchases.purchased_week desc]
      limit: 500
      query_timezone: America/Los_Angeles
      color_application:
        collection_id: legacy
        palette_id: mixed_pastels
        options:
          steps: 5
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      plot_size_by_field: false
      trellis: ''
      stacking: ''
      limit_displayed_rows: false
      legend_position: center
      series_types: {}
      point_style: none
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      hidden_fields: [purchases.total_cost_in_usd]
      join_fields: []
    - model: absolve
      explore: co2
      type: looker_line
      fields: [order_items.created_week, order_items.total_gross_margin]
      fill_fields: [order_items.created_week]
      filters:
        order_items.created_week: 6 weeks
      sorts: [order_items.created_week desc]
      limit: 500
      query_timezone: America/Los_Angeles
      color_application:
        collection_id: legacy
        palette_id: mixed_pastels
        options:
          steps: 5
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      plot_size_by_field: false
      trellis: ''
      stacking: ''
      limit_displayed_rows: false
      legend_position: center
      point_style: none
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: true
      interpolation: linear
      hidden_fields: []
      join_fields:
      - field_name: order_items.created_week
        source_field_name: purchases.purchased_week
    color_application:
      collection_id: legacy
      palette_id: mixed_pastels
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: purchases.total_carbon_offset,
            id: purchases.total_carbon_offset, name: Total Co2 offset (kg)}, {axisId: carbon_cruncher.carbon_footprint,
            id: carbon_cruncher.carbon_footprint, name: CO2e Footprint (kg)}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      purchases.total_cost_in_usd: "#fdb462"
      order_items.total_gross_margin: "#80b1d3"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    type: looker_column
    hidden_fields:
    listen:
    -
    - Date: order_facts.created_date
    row: 36
    col: 12
    width: 12
    height: 7
  - title: Orders YoY
    name: Orders YoY
    model: absolve
    explore: order_items
    type: looker_line
    fields: [order_items.created_year, order_items.created_month_name, order_items.total_sale_price]
    pivots: [order_items.created_year]
    fill_fields: [order_items.created_year, order_items.created_month_name]
    sorts: [order_items.created_year desc 0, order_items.created_month_name]
    limit: 500
    color_application:
      collection_id: legacy
      palette_id: mixed_pastels
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    listen: {}
    row: 6
    col: 0
    width: 12
    height: 9
  - title: Untitled
    name: Untitled
    model: absolve
    explore: order_items
    type: single_value
    fields: [order_items.30_day_repeat_purchase_rate]
    limit: 500
    custom_color_enabled: true
    custom_color: "#8dd3c7"
    show_single_value_title: true
    single_value_title: Repeat Purchase Rate
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    row: 2
    col: 12
    width: 6
    height: 4
  - name: ''
    type: text
    body_text: <center><code><font size="7"> Carbon Footprint</font></code></center>
    row: 23
    col: 0
    width: 24
    height: 5
  - title: Highest Impact Orders
    name: Highest Impact Orders
    model: absolve
    explore: co2
    type: table
    fields: [orders.id, order_facts.created_date, distribution_centers.name, users.city,
      users.state, order_items.total_sale_price, products.total_weight, users.country,
      carbon_cruncher.carbon_footprint_with_tgm]
    sorts: [order_facts.created_date desc]
    limit: 100
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_column_widths: {}
    series_cell_visualizations:
      order_items.total_sale_price:
        is_active: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_types: {}
    listen:
      Date: order_facts.created_date
    row: 43
    col: 0
    width: 24
    height: 6
  - title: kg Co₂ Offset
    name: kg Co₂ Offset
    model: offsets
    explore: purchases
    type: single_value
    fields: [purchases.total_carbon_offset]
    limit: 500
    custom_color_enabled: true
    custom_color: "#8dd3c7"
    show_single_value_title: true
    value_format: "#,##0"
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      Date: purchases.purchased_date
    row: 28
    col: 12
    width: 12
    height: 4
  filters:
  - name: Date
    title: Date
    type: date_filter
    default_value: 90 days
    allow_multiple_values: true
    required: false
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: absolve
    explore: order_items
    listens_to_filters: [Country]
    field: users.state
  - name: City
    title: City
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: absolve
    explore: order_items
    listens_to_filters: [State, Country]
    field: users.city
  - name: User ID
    title: User ID
    type: number_filter
    default_value: ''
    allow_multiple_values: true
    required: false
