
class Book
  attr_reader :author, :id, :title
  attr_accessor :status

  def initialize(title, author, id = nil)
    @author = author
    @title = title
    @id = id
    @status = "available"
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      return true
    else
      return false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
      return true
    else
      return false
    end
  end
end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library 
  attr_reader :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  def add_book(title, author)
    @books<<(Book.new(title, author, @books.length))
  end

  def check_out_book(book_id, borrower)
    @books.each do |library_book|
      if library_book.id == book_id && library_book.status == "available"
        library_book.check_out
        puts "Hey!"
        return library_book
      end
    end
  end

  def get_borrower(book_id)
  end

  def check_in_book(book)
    if book.status == "checked_out"
      book.status = "available"
      return true
    else
      return false
    end
  end

  def available_books
  end

  def borrowed_books
  end
end
