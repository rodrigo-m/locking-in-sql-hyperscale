/* Connection 2: writer, updating */
/* assumption: RCSI is enabled throughout the exercise, the default for Hyperscale */
SELECT name, snapshot_isolation_state_desc, is_read_committed_snapshot_on
FROM sys.databases

/* The update could be blocked by other connections that are writing to the database, but not by readers (selects) */

select * from dbo.test_01

/* The commands below will leave an open transaction with an exclusive lock for the row (in normal circumstances) */
BEGIN TRANSACTION

update dbo.test_01
set [name] = 'first, updated'
where [id] = 1

/* you can see the update for this connection id */
select * from dbo.test_01

-- ROLLBACK TRANSACTION

/* Showing that you have table/page/row locks at the moment. In normal conditions, this will generate an exclusive ('X') lock on the page only */
SELECT resource_type, resource_associated_entity_id,
  request_status, request_mode,request_session_id,
  resource_description
  FROM sys.dm_tran_locks
  where resource_type <> 'DATABASE'
