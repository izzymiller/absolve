view: derived_table_hannacase {

    derived_table: {
      sql: -- use existing order_facts in `lookerdata.looker_scratch.LR_GMMNX1644260393860_order_facts`
              SELECT
                  TRIM(products.category)  AS products_category,
                  COUNT(DISTINCT products.id ) AS products_count,
                  COUNT(DISTINCT CASE WHEN order_facts.order_sequence_number = 1  THEN order_items.order_id  ELSE NULL END) AS order_items_hidden_first_purchase_visualization_link,
                  COUNT(DISTINCT CASE WHEN order_facts.order_sequence_number = 1  THEN order_items.order_id  ELSE NULL END) AS order_items_first_purchase_count
              FROM absolve.order_items  AS order_items
              LEFT JOIN `lookerdata.looker_scratch.LR_GMMNX1644260393860_order_facts` AS order_facts ON order_facts.order_id = order_items.order_id
              FULL OUTER JOIN absolve.inventory_items  AS inventory_items ON inventory_items.id = order_items.inventory_item_id
              LEFT JOIN absolve.products  AS products ON products.id = inventory_items.product_id
              GROUP BY
                  1
              ORDER BY
                  2 DESC
              LIMIT 10
               ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: products_category {
      type: string
      sql: ${TABLE}.products_category ;;
    }

    dimension: products_count {
      type: number
      sql: ${TABLE}.products_count ;;
    }

    dimension: order_items_hidden_first_purchase_visualization_link {
      type: number
      sql: ${TABLE}.order_items_hidden_first_purchase_visualization_link ;;
    }

    dimension: order_items_first_purchase_count {
      type: number
      sql: ${TABLE}.order_items_first_purchase_count ;;
    }

    set: detail {
      fields: [products_category, products_count, order_items_hidden_first_purchase_visualization_link, order_items_first_purchase_count]
    }
  }
