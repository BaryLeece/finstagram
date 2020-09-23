get '/login' do    # when a GET request comes into /login
  erb(:login)      # render app/views/login.erb
end

get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  @current_user = User.find_by(id: session[:user_id])
  erb(:index)
end

post '/finstagram_posts' do
  photo_url = params[:photo_url]

  @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id })

  if @finstagram_post.save
    redirect(to('/'))
  else
    @finstagram_post.errors.full_messages.inspect
  end
end

post '/finstagram_posts' do
  params.to_s
end

get '/finstagram_posts/:id' do
  params[:id]
end

get '/finstagram_posts/:id' do
  @finstagram_post = FinstagramPost.find(params[:id])   # find the finstagram post with the ID from the URL
  erb(:"finstagram_posts/show")               # render app/views/finstagram_posts/show.erb
end

post '/signup' do
  email      = params[:email]
  avatar_url = params[:avatar_url]
  username   = params[:username]
  password   = params[:password]

  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

  if @user.save
    redirect to('/login')
  else
    erb(:signup)
  end
end

post '/login' do
  username = params[:username]
  password = params[:password]

  user = User.find_by(username: username)  

  if user && user.password == password
    session[:user_id] = user.id
    redirect to('/')
  else
    @error_message = "Login failed."
    erb(:login)
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
end