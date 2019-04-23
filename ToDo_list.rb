require 'sinatra'
require "make_todo"

get '/' do
    unless params[:show]
        erb :forms
    end
end

post "/allitems" do
    @message = ""
    all_tasks = Tarea.all 
    all_tasks.each do |task|
        @message += "#{task["id"]},#{task["title"]},#{task["done"]}  "
    end

    erb :tables

end

post "/create" do
    if params[:title]==""
        @message = "Debes asignar un titulo a la Tarea"
    else                
        title = params[:title]
        created = Tarea.create(title)
        @message = "Tu tarea fue creada existosamente con ID: #{created["id"]}"  
    end
    erb :comeback
end

post "/update" do
    id = params[:id].to_i
    Tarea.update(id)
    @message = "Estado de tarea con id:#{id} actualizado a '<i>Realizado</i>'"
    erb :comeback
end

post "/delete" do
    id = params[:id].to_i
    Tarea.destroy(id)
    @message = "Tu tarea con id:#{id} ha sido '<i>Eliminada</i>'"
    erb :comeback
end

post "/menu" do  
    redirect "/"
end