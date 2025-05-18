backup-db:
	node src/scripts/backup-db.js

restore-db:
ifndef DUMP
	$(error пример make restore-db DUMP=./db_backups/admin+students.sql)
endif
	@echo "⏳ Восстановление базы данных из дампа: $(DUMP)"
	node src/scripts/restore-db.js $(DUMP)


reset-db:
	node src/scripts/reset-db.js