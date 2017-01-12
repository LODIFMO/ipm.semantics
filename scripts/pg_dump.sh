docker exec -t testdocker_db_1 pg_dumpall -c -U postgres > dump_`date +%d-%m-%Y"_"%H_%M`.sql
