module vsql

// print sql to object struct for debug
pub fn (db &DB) print_obj() &DB {
	println(db.stmt)
	return db
}

// print sql string for debug
pub fn (db &DB) print_sql() &DB {
	s := db.gen_sql()
	println(s)
	return db
}

// generate sql string for debug
// do not use together with end()
pub fn (db &DB) to_sql() string {
	s := db.gen_sql()
	// after to_sql clear the db.stmt,that do not impact next sql
	db.stmt = Stmt{}
	return s
}

// debug mode
pub fn (db &DB) debug() {
}

// timeout,only mysql pg
pub fn (db &DB) timeout(during int) {
}
