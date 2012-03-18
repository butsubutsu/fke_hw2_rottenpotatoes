class MoviesController < ApplicationController
  
  



  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  
  
  def index
    
    sort_attrib=params[:sort]
    if sort_attrib != nil && Movie.all.map{|m| m.respond_to?(sort_attrib.to_sym)}.reduce(:&) 
      then @movies = #Movie.all.sort_by{|a| a.send(sort_attrib.to_sym)}
      Movie.order(sort_attrib.to_s)
     #debugger
      #self.xpc[params[:class]]="hilite"
      #session.keys.select{|k| k.to_s =~/^sort_/ }
      session.delete_if{|k,v| k.to_s =~/^sort_/ }
      session[("sort_"+params[:sort].to_s).to_sym]="hilite"
      #debugger
    else
    @movies = Movie.all#.sort_by {|a| a.title}
    session.delete_if{|k,v| k.to_s =~/^sort_/ }  
    end 
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
