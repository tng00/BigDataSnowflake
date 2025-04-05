SELECT c.column_name 
FROM information_schema.columns c 
WHERE c.table_name = 'mock_data'
ORDER BY c.column_name;