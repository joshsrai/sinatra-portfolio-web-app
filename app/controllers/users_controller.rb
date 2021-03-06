class UsersController < ApplicationController

    #login page, render the login  page - form
    get '/login' do
        erb :login
    end

    #to receive the login form, find user and log the user in (to create a session)
    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Welcome, #{@user.name.capitalize}!"
            redirect "users/#{@user.id}"
        else
            flash[:errors] = "Uh-oh. Either the Email or Password is incorrect. Please try again or Sign Up."
            redirect '/login'
        end
    end

    #render signup form
    get '/signup' do
        erb :signup 
    end

    #create a new user and persist the user to the DB
    post '/users' do
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id
            flash[:message] = "Congrats! #{@user.name.capitalize}, you have created a Devotions Account!"
            redirect "/users/#{@user.id}"
        else
            flash[:errors] = "Uh-Oh. We weren't able to make an account because #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'	
        end
    end

    #show route
    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        redirect_if_not_logged_in

        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end


end