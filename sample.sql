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
cancel (キャンセルしたいクエリのプロセスID);


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
