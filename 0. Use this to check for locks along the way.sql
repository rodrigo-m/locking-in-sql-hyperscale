/* Showing that you have no table/page/row locks at the moment */
SELECT resource_type, resource_associated_entity_id,
  request_status, request_mode,request_session_id,
  resource_description
  FROM sys.dm_tran_locks
  where resource_type <> 'DATABASE'