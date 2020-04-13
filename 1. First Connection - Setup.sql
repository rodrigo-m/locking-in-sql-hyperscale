/* Connection 1: setup and reset */ 
/* If you have executed scripts that leave open transactions and want to start over,        */
/* close all scripts before you run this setup script again.                                */
/* Closing the scripts will kill the connection and rollback the open transactions          */ 

if OBJECT_ID('test_01') is not NULL 
    drop table dbo.test_01

create table dbo.test_01 (
    [id] int,
    [Name] nvarchar(50)
)
GO

insert dbo.test_01
values 
    (1, 'first'),
    (2, 'second'),
    (3, 'third')
GO

select * from dbo.test_01

/* Showing that you have no table/page/row locks at the moment */
SELECT resource_type, resource_associated_entity_id,
  request_status, request_mode,request_session_id,
  resource_description
  FROM sys.dm_tran_locks
  where resource_type <> 'DATABASE'
