module vsql

// status: wip
// a bug in ...args,just waiting for fixed in V
// pub fn (mut db DB) where_raw(raw string,...args interface) &DB {
// mut s := db.stmt as Select
// count := raw.count('?')
// times := if count == -1 { 0 } else { count }
// len := args.len
// if times != len {
// panic('the ? count is not match argument count')
// }
// mut condition := raw
// for arg in args {
// condition = condition.replace_once('?', arg)
// }
// db.where << Where{
// condition: condition
// }
// return db
// }
// ---------------
fn (mut db DB) where_typ(typ, operator, condition string) &DB {
	w := Where{
		typ: typ
		operator: operator
		condition: condition
	}
	stmt:=db.stmt
	match stmt {
		Select { stmt.where << w }
		Update { stmt.where << w }
		Delete { stmt.where << w }
		else { panic('unknown where clause') }
	}
	return db
}

// status:done
pub fn (mut db DB) where(condition string) &DB {
	return db.where_typ('where', '', condition)
}

// status:done
pub fn (mut db DB) or_where(condition string) &DB {
	return db.where_typ('where', 'or', condition)
}

// status:done
pub fn (mut db DB) and_where(condition string) &DB {
	return db.where_typ('where', 'and', condition)
}

// status:done
pub fn (mut db DB) where_not(condition string) &DB {
	return db.where_typ('where', 'and not', condition)
}

// status:done
pub fn (mut db DB) and_where_not(condition string) &DB {
	return db.where_typ('where', 'and not', condition)
}

// status:done
pub fn (mut db DB) or_where_not(condition string) &DB {
	return db.where_typ('where', 'or not', condition)
}

// ---------------
fn (mut db DB) where_in_typ(typ, operator, column string, range []string) &DB {
	w := Where{
		typ: typ
		operator: operator
		column_name: column
		range: range
	}
	stmt:=db.stmt
	match db.stmt {
		Select { stmt.where << w }
		Update { stmt.where << w }
		Delete { stmt.where << w }
		else { panic('unknown where clause') }
	}
	return db
}

// status:done
pub fn (mut db DB) where_in(column string, range []string) &DB {
	return db.where_in_typ('where_in', '', column, range)
}

// status:done
pub fn (mut db DB) or_where_in(column string, range []string) &DB {
	return db.where_in_typ('where_in', 'or', column, range)
}

// status:done
pub fn (mut db DB) and_where_in(column string, range []string) &DB {
	return db.where_in_typ('where_in', 'and', column, range)
}

// status:done
pub fn (mut db DB) where_not_in(column string, range []string) &DB {
	return db.where_in_typ('where_in', 'and not', column, range)
}

// status:done
pub fn (mut db DB) or_where_not_in(column string, range []string) &DB {
	return db.where_in_typ('where_in', 'or not', column, range)
}

// ---------------
fn (mut db DB) where_null_typ(typ, operator, column string) &DB {
	w := Where{
		typ: typ
		operator: operator
		column_name: column
	}
	stmt:=db.stmt
	match db.stmt {
		Select { stmt.where << w }
		Update { stmt.where << w }
		Delete { stmt.where << w }
		else { panic('unknown where clause') }
	}
	return db
}

// status:done
pub fn (mut db DB) where_null(column string) &DB {
	return db.where_null_typ('where_null', '', column)
}

// status:done
pub fn (mut db DB) or_where_null(column string) &DB {
	return db.where_null_typ('where_null', 'or', column)
}

// status:done
pub fn (mut db DB) and_where_null(column string) &DB {
	return db.where_null_typ('where_null', 'and', column)
}

// status:done
pub fn (mut db DB) where_not_null(column string) &DB {
	return db.where_null_typ('where_null', 'and not', column)
}

// status:done
pub fn (mut db DB) or_where_not_null(column string) &DB {
	return db.where_null_typ('where_null', 'or not', column)
}

// ---------------
fn (mut db DB) where_between_typ(typ, operator, column string, range []string) &DB {
	w := Where{
		typ: typ
		operator: operator
		column_name: column
		range: range
	}
	stmt:=db.stmt
	match db.stmt {
		Select { stmt.where << w }
		Update { stmt.where << w }
		Delete { stmt.where << w }
		else { panic('unknown where clause') }
	}
	return db
}

// status:done
pub fn (mut db DB) where_between(column string, range []string) &DB {
	return db.where_between_typ('where_between', '', column, range)
}

// status:done
pub fn (mut db DB) or_where_between(column string, range []string) &DB {
	return db.where_between_typ('where_between', 'or', column, range)
}

// status:done
pub fn (mut db DB) and_where_between(column string, range []string) &DB {
	return db.where_between_typ('where_between', 'and', column, range)
}

// status:done
pub fn (mut db DB) where_not_between(column string, range []string) &DB {
	return db.where_between_typ('where_between', 'and not', column, range)
}

// status:done
pub fn (mut db DB) or_where_not_between(column string, range []string) &DB {
	return db.where_between_typ('where_between', 'or not', column, range)
}

// ---------------
fn (mut db DB) where_exists_typ(typ, operator, stmt string) &DB {
	w := Where{
		typ: typ
		operator: operator
		exist_stmt: stmt
	}
	stmt:=db.stmt
	match stmt {
		Select { stmt.where << w }
		Update { stmt.where << w }
		Delete { stmt.where << w }
		else { panic('unknown where clause') }
	}
	return db
}

pub fn (mut db DB) where_exists(stmt string) &DB {
	return db.where_exists_typ('where_exists', '', stmt)
}

pub fn (mut db DB) or_where_exists(stmt string) &DB {
	return db.where_exists_typ('where_exists', 'or', stmt)
}

pub fn (mut db DB) and_where_exists(stmt string) &DB {
	return db.where_exists_typ('where_exists', 'and', stmt)
}

pub fn (mut db DB) where_not_exists(stmt string) &DB {
	return db.where_exists_typ('where_exists', 'not', stmt)
}

pub fn (mut db DB) or_where_not_exists(stmt string) &DB {
	return db.where_exists_typ('where_exists', 'or not', stmt)
}
