require 'sqlite3'
require_relative '../config'

db = SQLite3::Database.new(DB_PATH)

db.execute('DROP TABLE IF EXISTS todos')

db.execute('CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL, 
            description TEXT,
            status INTEGER DEFAULT 0,
            category_id INTEGER )')

db.execute('CREATE TABLE categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL )')

db.execute('INSERT INTO categories (name) VALUES ("Mat")')
db.execute('INSERT INTO categories (name) VALUES ("Julen")')

db.execute('INSERT INTO todos (name, description, status, category_id) VALUES ("Köp mjölk", "3 lite mellanmjölk, eko", 1, 0)')
db.execute('INSERT INTO todos (name, description, status, category_id) VALUES ("Köp julgran", "En rödgran", 0, 1)')
db.execute('INSERT INTO todos (name, description, status, category_id) VALUES ("Pynta gran", "Glöm inte lamporna i granen och tomten", 0, 1)')
db.execute('INSERT INTO todos (name, description, status, category_id) VALUES ("Laga tomtegröt", "Glöm inte kanelstången!", 0, 0)')

puts "✅ Databasen är seedad!"