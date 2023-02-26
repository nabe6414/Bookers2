class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success_book] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user_info = User.find(current_user.id)
      @post = Book.new
      render :index
    end
  end

  def index
    @books = Book.all
    @user_info = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user_info = @book.user
    @post = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    is_matching_book_user
  end

  def update
    @book = Book.find(params[:id])
    is_matching_book_user
    if @book.update(book_params)
      flash[:update_book] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_book_user
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
