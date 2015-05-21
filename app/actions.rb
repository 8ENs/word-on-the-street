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


get '/pins' do
  @pins = Pin.all
  erb :'pins/index'
end

get '/pins/new' do
  @pin = Pin.new
  erb :'pins/new'
end

get '/pins/:id' do
  @pin = Pin.find(params[:id])
  erb :'pins/show'
end

post '/pins' do
  @pin = Pin.new(
    message:   params[:message],
    location:  params[:location],
    recipient:   params[:recipient],
    url:   params[:url]
  )
  @pin.user_id = session[:id]
  if @pin.save
    redirect '/pins'
  else
    erb :'pins/new'
  end
end

# post '/pins/upvote' do
#   Vote.create(
#     user_id: session[:id],
#     pin_id: params[:pinid],
#     vote: 1
#   )
#   t = pin.find(params[:pinid])
#   t.save

#   redirect '/pins' # :back
#   # if @pin.save
#   #   redirect '/pins'
#   # else
#   #   erb :'pins/new'
#   # end
# end
