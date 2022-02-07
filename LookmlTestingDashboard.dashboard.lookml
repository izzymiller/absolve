- dashboard: testlookmldashboard
  title: TestLookmlDashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: ordersPerYear
    name: ordersPerYear
    model: absolve
    explore: order_items
    type: looker_grid
    fields: [order_items.order_count, order_facts.created_year]
    fill_fields: [order_facts.created_year]
    sorts: [order_items.order_count desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    row:
    col:
    width:
    height:
