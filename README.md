# Operational Efficiency Analysis (SQL + Power BI)

## Overview

This project analyzes operational efficiency in an order fulfillment process using SQL and Power BI. The goal was to identify process bottlenecks, evaluate team and regional performance, and provide actionable recommendations to improve delivery speed and reliability.

The workflow includes raw data ingestion, transformation into analytical metrics, and interactive dashboard development.

---

## Objectives

* Analyze end-to-end order fulfillment performance
* Identify operational bottlenecks across process stages
* Evaluate team and regional efficiency differences
* Measure delivery performance and on-time rates
* Support data-driven decision-making

---

## Tools & Technologies

* SQL (data transformation & analysis)
* Power BI (dashboard & visualization)
* CSV (data source)
* GitHub (project documentation)

---

## Data Pipeline

1. Raw CSV data imported into SQL
2. Staging table used for initial data ingestion
3. Cleaned and structured into a relational table
4. Analytical view (`order_metrics`) created with derived KPIs
5. Data connected to Power BI for visualization

---

## Key Metrics

* Average Delivery Time
* Queue Time (order → processing start)
* Handling Time (processing → shipping)
* Transit Time (shipping → delivery)
* On-Time Delivery Rate
* Cancellation Rate
* Total Orders & Revenue

---

## Dashboard

### Executive Overview

* Order volume trends over time
* Overall delivery performance
* On-time delivery rate
* Regional and team-level breakdown

### Bottleneck Analysis

* Process time breakdown (queue, handling, transit)
* Identification of delays across teams
* Comparison of operational efficiency

### Performance Comparison

* Team-level performance benchmarking
* Delivery time vs on-time rate analysis
* Revenue and cancellation comparisons

---

## Key Insights

**1. Process Bottleneck Identified**
The main delay occurs before order processing begins, indicating inefficiencies in queue management and workload distribution.

**2. Team Performance Variation**
Significant differences were observed between teams, suggesting inconsistent processes and resource allocation.

**3. Low On-Time Delivery Rate**
Delivery performance indicates a mismatch between promised timelines and actual operational capacity.

**4. Demand Peaks Impact Performance**
Higher order volumes correlate with increased delivery times, highlighting scalability challenges.

---

## Recommendations

* Optimize queue management and reduce processing delays
* Balance workload across teams
* Align delivery promises with actual performance
* Improve capacity planning during peak periods
* Introduce performance monitoring at team level

---

## Business Value

This analysis improves operational transparency and enables more efficient resource allocation. By identifying bottlenecks and performance gaps, organizations can reduce delivery times, improve service reliability, and enhance customer satisfaction.

---

## Project Structure

```
/data
/sql
/powerbi
/images
README.md
```

---

## Author

Operational Efficiency Analysis Project
SQL + Power BI Portfolio Project
