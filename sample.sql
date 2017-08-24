# 2つのテーブルの差分を比較
# 以下の2つのクエリでcountが0ならばOK
SELECT COUNT(1)
FROM (
  SELECT * FROM xxx
  MINUS
  SELECT * FROM yyy
) t
;

SELECT COUNT(1)
FROM (
  SELECT * FROM yyy
  MINUS
  SELECT * FROM xxx
) t
;

# 実行中クエリのプロセスIDを調査
select pid, user_name, starttime, query
from stv_recents
where status='Running';

# 実行中クエリをキャンセル
cancel キャンセルしたいクエリのプロセスID;


# s3からのcopy処理エラーログを確認
SELECT
    TRIM(userid) AS userid,
    TRIM(slice) AS slice,
    TRIM(tbl) AS tbl,
    TRIM(starttime) AS starttime,
    TRIM(session) AS session, 
    TRIM(query) AS query,
    TRIM(filename) AS filename,
    TRIM(line_number) AS line_number,
    TRIM(colname) AS colname,
    TRIM(type) AS type,
    TRIM(col_length) AS col_length,
    TRIM(position) AS position,
    TRIM(raw_line) AS raw_line,
    TRIM(raw_field_value) AS raw_field_value,
    TRIM(err_code) AS err_code,
    TRIM(err_reason) AS err_reason
FROM
  STL_LOAD_ERRORS
ORDER BY starttime DESC
LIMIT 20;

-- テーブルidとdb名,schema名,テーブル名を表示
create view dim_test_ticket_25900_2.tables_vw as
  select distinct(id) table_id
    ,trim(datname)   db_name
    ,trim(nspname)   schema_name
    ,trim(relname)   table_name
  from stv_tbl_perm
  join pg_class on pg_class.oid = stv_tbl_perm.id
  join pg_namespace on pg_namespace.oid = relnamespace
  join pg_database on pg_database.oid = stv_tbl_perm.db_id;


-- 現在のトランザクションで発生しているすべてのロックを表示
select table_id, last_update, lock_owner, lock_owner_pid from stv_locks;
