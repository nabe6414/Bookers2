class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.id = current_user.id
    @book.save
    redirect_to book_path
  end

  def index
    @books = Book.all
  end

  def show
    @book = book.find(params[:id])
  end

  def edit
    @book = book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
