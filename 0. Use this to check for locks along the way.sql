/* One of the main points of this micro tutorial is to show that:                                     */
/* - When RCSI is enabled,                                                                            */
/* -- Readers will not be blocked by writers                                                          */
/* -- Writers may be blocked by readers                                                               */
/*                                                                                                    */
/* In our context, reader means a select, write means insert/update/delete                            */
/* RCSI stands for Read Committed Snapshot Isolation and it is enabled by default in SQL Hyperscale   */

/* The query below will show you locks you have at the moment */
/* It excludes DATABASE locks as those are not particularly relevant for this tutorial */
SELECT resource_type, resource_associated_entity_id,
  request_status, request_mode,request_session_id,
  resource_description
  FROM sys.dm_tran_locks
  where resource_type <> 'DATABASE'