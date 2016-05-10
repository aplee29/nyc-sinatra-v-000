class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/edit'
  end

  post '/landmarks' do
    Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    redirect "/landmarks"
  end

  # edits landmark
  post '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])

    unless params[:owner][:name].empty?
      @landmark.figure = Figure.find_or_create_by(name: params[:figure][:name])
       @landmark.save
    end

    redirect "/landmarks/#{@landmark.id}"
  end

end