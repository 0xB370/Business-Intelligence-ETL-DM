# ETL

Data Warehouse creation and loading project based on TPC Benchmark.

Includes the creation script for the Data Warehouse and ETL package that uses the file tpcc.bak (which can be found on the company's official webpage, with the corresponding description of tables, columns and all relevant data), applying SSIS for data loading.

The model proposed for the solution is as follows:

![Image description](https://i.imgur.com/tFGOtcP.jpg)

The ETL proccess proposed to be followed:

![Image description](https://i.imgur.com/YJzq9RD.jpg)

For this solution, was applied stage tables for insert, update and delete operations. These tables are truncated in next ETL execution, giving to administrator the possibility to control them.

# OLAP: 

OLAP cube creation project using SSAS, taking the Data Warehouse obtained in ETL project previously described.

# Data-Mining:

Predictive analytics project applying Data Mining with neural networks, time series and Naive Bayes algorithms. The projects mentioned above are taken as starting point.
