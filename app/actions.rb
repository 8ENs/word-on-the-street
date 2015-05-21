# Homepage (Root path)
get '/' do
  erb :index
end

get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/users/register' do
  @user = User.new
  erb :'users/register'
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'users/show'
end

post '/users' do
  @user = User.new(
    name:   params[:user_name],
    email:  params[:user_email],
    password:  params[:user_password]
  )
  if @user.save
    session[:id] = @user.id
    session[:name] = @user.name
    redirect '/'
  else
    erb :'users/register'
  end
end

get '/login' do
  @user = User.new
  erb :'login'
end

get '/logout' do
  session.destroy
  redirect '/'
end

post '/login' do
  @user = User.find_by(email: params[:user_email], password: params[:user_password])
  # @user = User.find_by_email(params[:user_email])

  if @user
    # authenticate
    session[:id] = @user.id
    session[:name] = @user.name
    redirect '/'
  else
    @user = User.new
    @user.errors[:email] << "Login failed. Please try again."
    # @messages[:email] << "Login failed. Please try again."
    erb :'login'
  end
end

# if session[:id] != ""
#   @current_user = User.find_by(id: session[:id])
# end

# helpers do
#   def user_logged_in?
#     session[:id] && session[:id] != ""
#   end

#   def get_current_user
#     if user_logged_in?
#       User.find_by(id: session[:id])
#     end
#   end
# end

# <% if user_logged_in? %>
#   <p>Welcome <%= get_current_user.name %></p>
# <% end %>


get '/tracks' do
  @tracks = Track.order(likes: :desc)
  @votes = Vote.where(user_id: session[:id])
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Track.find(params[:id])
  erb :'tracks/show'
end

post '/tracks' do
  @track = Track.new(
    song:   params[:song],
    album:  params[:album],
    artist:   params[:artist],
    url:   params[:url]
  )
  @track.user_id = session[:id]
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

post '/tracks/upvote' do
  Vote.create(
    user_id: session[:id],
    track_id: params[:trackid],
    vote: 1
  )
  t = Track.find(params[:trackid])
  t.likes += 1
  t.save

  redirect '/tracks' # :back
  # if @track.save
  #   redirect '/tracks'
  # else
  #   erb :'tracks/new'
  # end
end
