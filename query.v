module vsql

pub type CallbackFn = fn ()

// status:done
pub fn (db &DB) table(name string) &DB {
	table_name, table_alias := split_by_separator(name, 'as')
	db.stmt.typ = .select_
	db.stmt.table_name = table_name
	db.stmt.table_alias = table_alias
	return db
}

// status:done
pub fn (db &DB) column(columns string) &DB {
	if columns in [' ', '*'] {
		db.stmt.columns = []Column{}
	} else {
		column_array := columns.split(',')
		// mut name := ''
		// mut alias := ''
		for col in column_array {
			name, alias := split_by_separator(col, 'as') // deal with column and column alias,like:column('id,name as name2,age as age2')
			db.stmt.columns << Column{
				name: name
				alias: alias
			}
		}
	}
	return db
}

// the same with table()
// status:done
pub fn (db &DB) from(name string) &DB {
	return db.table(name)
}

// the same with column()
// status:done
pub fn (db &DB) select_(columns string) &DB {
	return db.column(columns)
}

// status:done
pub fn (db &DB) first() &DB {
	db.stmt.first = true
	return db
}

// status:done
pub fn (db &DB) limit(num int) &DB {
	db.stmt.limit = num
	return db
}

// status:done
pub fn (db &DB) offset(num int) &DB {
	db.stmt.offset = num
	return db
}

// status:done
pub fn (db &DB) distinct() &DB {
	db.stmt.is_distinct = true
	return db
}

// status:done
pub fn (db &DB) group_by(column string) &DB {
	db.stmt.group_by << column
	return db
}

// status:done
pub fn (db &DB) group_by_raw(raw string) &DB {
	db.stmt.group_by_raw = raw
	return db
}

// status:done
pub fn (db &DB) order_by(column string) &DB {
	col, mut order := split_by_space(column)
	if order == '' {
		order = 'asc'
	}
	if order !in ['asc', 'desc'] {
		panic('order by must be asc or desc')
	}
	db.stmt.order_by << OrderBy{
		column: col
		order: order
	}
	return db
}

// status:done
pub fn (db &DB) order_by_raw(raw string) &DB {
	db.stmt.order_by_raw = raw
	return db
}

// status:done
pub fn (db &DB) having(condition string) &DB {
	db.stmt.having = condition
	return db
}

// union statement
// status:wip
pub fn (db &DB) union_(union_fn CallbackFn) &DB {
	return db
}

// status:wip
pub fn (db &DB) union_all(union_fn CallbackFn) &DB {
	return db
}

// status:wip
pub fn (db &DB) intersect(union_fn CallbackFn) &DB {
	return db
}

// status:wip
pub fn (db &DB) except(union_fn CallbackFn) &DB {
	return db
}

// result to struct
// status:wip
pub fn (db &DB) to() &DB {
	return db
}
