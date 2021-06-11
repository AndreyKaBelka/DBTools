/opt/mssql/bin/sqlservr &

for _ in {1..50}; do
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -i /scripts/entrypoint.sql
  if [ $? -eq 0 ]; then
    echo "sql completed"
    break
  else
    echo "not ready yet..."
    sleep 1
  fi
done

sleep infinity;