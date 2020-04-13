/* Connection 2: writer, deleting                                           */
/* Scenario: a writer *may be* blocked by another writer. With a surprise.  */

/* Show connection id */
SELECT @@SPID;

/* Separating the batch with a "go", to show that a reader (select) will not be blocked by a writer (inserts/updates/deletes)   */
/* This first select will run fine. Note that it reflects the state of the database before the update on script (2), since      */
/*   that transaction did not commit at this point                                                                              */ 
select * from dbo.test_01
go

/* The commands below will be blocked by writers, but not by readers.                                                                        */
/* Note that the second select will not run because SQL is waiting on the delete statement that is blocked.                                  */
/*   the select command itself would not be blocked.                                                                                         */
/* Note that the row you are attempting to delete is not the same being updated by script 2, but still get blocked. Can you explain why?     */

/* The commands below will leave an open transaction with an exclusive lock */
BEGIN TRANSACTION

delete dbo.test_01
where [id] = 2

/* you can see the update for this connection id */
select * from dbo.test_01

-- ROLLBACK TRANSACTION

/* Hint: what are the possible ways that the row that is locked could change? */
/* Hint: in what conditions would the delete statement above delete more than one row? */
