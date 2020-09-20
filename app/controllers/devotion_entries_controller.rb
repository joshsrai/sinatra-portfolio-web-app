class DevotionEntriesController < ApplicationController

    get '/devotion_entries/new' do
        erb :'/devotion_entries/new'
    end

    post '/devotion_entries' do

        if !logged_in?
            redirect '/'
        end
        if params[:content] != ""
            @devotion_entry = DevotionEntry.create(content: params[:content], user_id: current_user.id)
            redirect "/devotion_entries/#{@devotion_entry.id}"
        else
            redirect '/devotion_entries/new'

        end
    end

    get '/devotion_entries/:id' do
        @devotion_entry = DevotionEntry.find(params[:id])
        erb :'/devotion_entries/show'
    end

    #to edit devotion entries
    get '/devotion_entries/10/edit' do
        erb :'devotion_entries/edit'
    end
    
    
end