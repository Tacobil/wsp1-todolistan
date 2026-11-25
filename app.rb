require 'debug'
require "awesome_print"

class App < Sinatra::Base
    register Sinatra::Reloader

    def db
      return @db if @db

      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
    end

    get '/todos' do
        @todos = db.execute('SELECT todos.*, categories.name AS category_name 
                            FROM todos INNER JOIN categories ON category_id = categories.id')
        @categories = db.execute('SELECT * FROM categories')
        erb(:'todos/index')
    end

    get '/todos/:id' do |id|
        @todo = db.execute('SELECT * FROM todos WHERE id=?', id).first
        erb(:'todos/show')
    end

    post '/todos' do
        # Ny todo
        t_name = params["todo_name"]
        t_desc = params["todo_description"]
        t_category_id = params["todo_category_id"]

        db.execute("INSERT INTO todos (name, description, status, category_id) VALUES (?, ?, 0, ?)", [t_name, t_desc, t_category_id])

        redirect('/todos')
    end

    post '/todos/:id/status' do |id|
        current_status = db.execute("SELECT status FROM todos WHERE id=?", id).first["status"]
        new_status = 0
        if current_status == 0
            new_status = 1
        end

        db.execute("UPDATE todos SET status=? WHERE id =?", [new_status, id])
        puts "STATUS: #{new_status}"
        redirect("/todos")
    end

    post '/todos/:id/delete' do |id|
        db.execute('DELETE FROM todos WHERE id=?', id)
        redirect("/todos")
    end
end
