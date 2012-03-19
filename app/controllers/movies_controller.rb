class MoviesController < ApplicationController
  
  def init_ratings
   # @all_ratings=Movie.all.map{|m| m.rating}.uniq
    @all_ratings=Movie.all_ratings
  end

def get_ratings_where
  rt=params[:ratings]
  bbb={}
  #An array may be used in the hash to use the SQL IN operator:
  bbb[:rating]=rt.keys unless rt==nil
  #track checkbox status
  @checked={}
  @checked=Hash[rt.keys.map{|k| [k,true]}] unless rt==nil
  return bbb
end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
 
  def index
    clear_col_header_classes
    #debugger
    init_ratings
    sort_attrib=params[:sort]
    
    if sort_attrib != nil && Movie.all.map{|m| m.respond_to?(sort_attrib.to_sym)}.reduce(:&) 
      then @movies = #Movie.all.sort_by{|a| a.send(sort_attrib.to_sym)}
      Movie.where(get_ratings_where).order(sort_attrib.to_s)
     #debugger
      #self.xpc[params[:class]]="hilite"
      #session.keys.select{|k| k.to_s =~/^sort_/ }
     # session.delete_if{|k,v| k.to_s =~/^sort_/ }
      session[("sort_"+params[:sort].to_s).to_sym]="hilite"
      #debugger
    else
    @movies = Movie.where(get_ratings_where)#.sort_by {|a| a.title}
    
    end 
  end
def clear_col_header_classes
  session.delete_if{|k,v| k.to_s =~/^sort_/ }  
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
