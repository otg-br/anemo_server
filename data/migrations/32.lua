function onUpdateDatabase()
	print("> Updating database to version 32 (Custom Ancestral Task System)")
	print("> If you have duplicated column on database from migrations, it's not an error, leave it and restart the console the duplicate will disappear.)")
	db.query("ALTER TABLE `players` ADD COLUMN `ancestral_points` INT UNSIGNED NOT NULL DEFAULT 0, ADD COLUMN `ancestral_rank_points` bigint UNSIGNED NOT NULL DEFAULT 1")
	return true
end
