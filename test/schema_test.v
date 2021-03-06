module test

import vsql
import dialect.pg

fn test_schema() {
	mut db := connect_and_init_db()
	mut res := []pg.Row{}
	// create database
	res = db.create_database('mydb')
	println(res)
	// create table
	db.create_table('person2', fn (mut table vsql.Table) {
		// table.increment('id').primary()
		table.increment('id')
		table.boolean('is_ok')
		table.string_('open_id', 255).size(100).unique()
		table.datetime('attend_time')
		table.string_('form_id', 255).not_null()
		table.integer('is_send').default_to('1')
		table.decimal('amount', 10, 2).not_null().check('amount>0')
		// table constraint
		table.primary(['id'])
		table.unique(['id'])
		table.check('amount>30')
		table.check('amount<60')
		result := table.to_sql()
		expert := "create table person2 (
id serial,
is_ok boolean,
open_id varchar(255) unique,
attend_time timestamp,
form_id varchar(255) not null,
is_send integer default '1',
amount decimal(10,2) not null check (amount>0),

primary key (id),
unique (id),
check (amount>30),
check (amount<60)
);"
		assert result == expert
	})
	// alter table
	//
	// rename table
	res = db.rename_table('person', 'new_person')
	println(res)
	// truncate table
	res = db.truncate('new_person')
	println(res)
	// drop table
	res = db.drop_table('food')
	println(res)
	// drop table if exist
	res = db.drop_table_if_exist('cat')
	println(res)
}
