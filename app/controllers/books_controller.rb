class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @books = Book.all
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  # 投稿データの保存
  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@new_book)
    else
      @books = Book.all
      render :index
    end
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])  # Bookを取得
    unless book.user == current_user
      redirect_to books_path
    end
  end
end