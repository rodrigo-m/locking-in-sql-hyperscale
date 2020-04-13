# Locking in Azure SQL Hyperscale
A micro-tutorial to highlight a few behaviors related to the Read Committed Snapshot Isolation (RCSI), the default for the primary node of Azure SQL Hyperscale.

Open the scripts in sequence in separate connections and run them in sequence. Read the comments to understand what is happening. Use script "0" to explore the locking state during the exercise. 

This works best if you do it in a database where no one else is connected. Alternatively, filter the locking dm view query for the connection ids for each of the connections you have open. 
