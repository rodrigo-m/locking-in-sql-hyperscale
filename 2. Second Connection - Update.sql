/* Connection 2: writer, updating */

/* Show connection id */
SELECT @@SPID;
GO

/* assumption: RCSI is enabled throughout the exercise, the default for Hyperscale */
SELECT name, snapshot_isolation_state_desc, is_read_committed_snapshot_on
FROM sys.databases
GO

/* Show the state of the table before the transaction */
select * from dbo.test_01
GO

/* The commands below will leave an open transaction with an exclusive lock for the row (in normal circumstances, with no lock escalation) */
BEGIN TRANSACTION

update dbo.test_01
set [name] = 'first, updated'
where [id] = 1

/* you can see the updated row within the context of this connection id */
select * from dbo.test_01

/* the command below is commented out so that the transaction stays open and the locks remain in place to interfere with the other scripts you will run */
-- ROLLBACK TRANSACTION

/* Showing that you have table/page/row locks at the moment. In normal circumstances, this will generate an exclusive ('X') lock on the page only */
SELECT resource_type, resource_associated_entity_id,
  request_status, request_mode,request_session_id,
  resource_description
  FROM sys.dm_tran_locks
  where resource_type <> 'DATABASE'
