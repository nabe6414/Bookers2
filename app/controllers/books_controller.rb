class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    flash[:success_book] = "You have created book successfully."
    redirect_to book_path(@book.id)
  end

  def index
    @books = Book.all
    @user_info = User.find(current_user.id)
    @post = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user_info = User.find(@book.user_id)
    @post = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    flash[:update_book] = "You have updated book successfully."
    redirect_to book_path(book.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
