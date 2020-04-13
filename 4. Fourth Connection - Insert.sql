/* Connection 2: writer a, updating */

/* Separating the batch with a "go", to show that a select will not be blocked by inserts/updates/deletes */
select * from dbo.test_01
go

/* The commands below will leave an open transaction. If the previous locks are row locks then nothing will block this insert */
/* Can you expain why in this scenaio the delete was blocked, but the insert was not? */
BEGIN TRANSACTION

INSERT dbo.test_01
VALUES (5, 'Fourth')

/* you can see the insert for this connection id */
select * from dbo.test_01

-- ROLLBACK TRANSACTION
