# Retail Sales Analytics – end-to-end SQL project

> PostgreSQL 15 data-warehouse + BI layer that replaced a fragile Excel process and cut month-end reporting time from 4 days to 30 minutes.

## 1. Business context
A three-store grocery chain needed visibility into daily sales, inventory turns, promotion effectiveness and shrinkage.  
The existing process was 100 % Excel and broke every time files exceeded 1 M rows.

## 2. Objectives
- Centralise POS, inventory and promo data in a single warehouse.  
- Deliver daily incremental loads with < 5 min latency.  
- Provide analysts with self-service, parameterised SQL views.  
- Guarantee ≤ 0.1 % reconciliation mismatch with finance GL.

## 3. Data model (star schema)