

Sample
```
-- List physical files and SQL tables
-- Only include data files, not source files
SELECT *
FROM QSYS2.SYSTABLES
WHERE TABLE_TYPE IN ('P', 'T')
AND TABLE_SCHEMA = '@@LIBRARY' 
AND FILE_TYPE = 'D';
```

