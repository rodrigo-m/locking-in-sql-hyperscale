/* Connection 2: writer, deleting */

/* Show connection id */
SELECT @@SPID;

/* Separating the batch with a "go", to show that a reader (select) will not be blocked by a writer (inserts/updates/deletes)   */
/* This first select will run fine. Note that it reflects the state of the database before the update on script (2), since      */
/*   that transaction did not commit at this point                                                                              */ 
select * from dbo.test_01
go

/* The commands below will be blocked by writers, but not by readers. Note that the second select will not run, as              */
/*   the batch is blocked at the delete statement                                                                               */
/* Note that you are attempting to delete a different row, but still get blocked. Can you explain why?                          */

/* The commands below will leave an open transaction with an exclusive lock */
BEGIN TRANSACTION

delete dbo.test_01
where [id] = 2

/* you can see the update for this connection id */
select * from dbo.test_01

-- ROLLBACK TRANSACTION

/* Hint: what are the possible ways that the row that is locked could change? */
/* Hint: in what conditions would the delete statement above delete more than one row? */
