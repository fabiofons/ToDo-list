require 'sinatra'
require "make_todo"

get '/' do
    unless params[:show]
    erb :forms

    else
        task_to_view = ""
        all_tasks = Tarea.all

        if params[:show]=="incomplete"   
            all_tasks.each do |task|
                if task["done"]==false
                    task_to_view += "La tarea <i>'#{task["title"]}'</i> con <i>ID:#{task["id"]}</i> no ha sido finalizada.  "
                end
            end
            @message = "#{task_to_view}"

        elsif params[:show]=="done"            
            all_tasks.each do |task|
                if task["done"]==true
                    task_to_view += "Tarea <i>'#{task["title"]}'</i> con <i>ID:#{task["id"]}</i> realizada.  "
                end
            end
            @message = "#{task_to_view}"

        elsif params[:show]=="create"
            if params[:id]==""
                @message = "Debes asignar un titulo a la Tarea"
            else                
                title = params[:id]
                created = Tarea.create(title)
                @message = "Tu tarea fue creada existosamente con ID: #{created["id"]}"  
            end

        elsif params[:show]=="finish"
            if params[:id] == ""
                @message = "Debes especificar un ID"
            else
                id = params[:id]
                Tarea.update(id)
                @message = "Estado de tarea con id:#{id} actualizado a '<i>Realizado</i>'"
            end

        elsif params[:show]=="delete"
            if params[:id] == ""
                @message = "Debes especificar un ID"
            else
                id = params[:id]
                Tarea.destroy(id)
                @message = "Tu tarea con id:#{id} ha sido '<i>Eliminada</i>'"
            end
        end

        erb :comeback
    end    
end

post "/menu" do # A pesar de que con el verbo get también puedo devolverme a la dirección "raiz" con el hash param = /? sin ningún problema, me pareció más limpio usar el redirect con el verbo post 
    redirect "/"
end