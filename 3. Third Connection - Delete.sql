/* Connection 2: writer a, deleting */

/* Separating the batch with a "go", to show that a select will not be blocked by inserts/updates/deletes */
select * from dbo.test_01
go

/* The commands below will be blocked by updates/inserts/deletes for the same row, but not by selects. Note that the second select will not run - it will be blocked by the update */
/* Note that you are attempting to delete a different row, but still get blocked. Can you explain why? */

/* The commands below will leave an open transaction with an exclusive lock */
BEGIN TRANSACTION

delete dbo.test_01
where [id] = 2

/* you can see the update for this connection id */
select * from dbo.test_01

-- ROLLBACK TRANSACTION

/* Hint: what are the possible ways that the row that is locked could change? */
/* Hint: in what conditions would the delete statement above delete more than one row? */


