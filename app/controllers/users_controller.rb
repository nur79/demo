class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :correct_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html do 
          flash[:success] = 'Welcome to the Sample App!'
          redirect_to @user
        end
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html do 
          flash[:success] = 'Profile updated!' 
          sign_in @user
          redirect_to @user
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html do 
        flash[:success] = "User destroyed!"
        redirect_to users_path
      end
      format.json { head :no_content }
    end
  end

  def following
    @title = "Following" 
    @user = User.find(params[:id]) 
    @users = @user.followed_users.paginate(page: params[:page]) 
    render 'show_follow'
  end

  def followers 
    @title = "Followers" 
    @user = User.find(params[:id]) 
    @users = @user.followers.paginate(page: params[:page]) 
    render 'show_follow'
  end

  private

    def correct_user 
      @user = User.find(params[:id]) 
      redirect_to root_path unless current_user?(@user)
    end

    def correct_admin 
      @user = User.find(params[:id]) 
      redirect_to root_path unless current_user.admin? and !current_user?(@user)
    end

end
