
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
  attr_reader:books

  def initialize#can remove name
    @books = []
    @borrower_hash = {} #key = book_id, value = borrower
  end

  def add_book(title, author)
    @books<<(Book.new(title, author, @books.length))
  end

  def books_checked_out_by(borrower)
    # @borrower_hash = { book => borrower}
    # return 1 if @borrower_hash.values.include? borrower
    @borrower_hash.values.count borrower
  end

  def check_out_book(book_id, borrower)
    if books_checked_out_by(borrower) == 1
        return nil
    else
      book = @books[book_id]
      if book.status == "available"
        book.check_out
        @borrower_hash[book_id] = borrower
        return book
      end
    end
  end

  def check_in_book(book)
    if book.status == "checked_out"
      book.status = "available"
      return true
    else
      return false
    end
  end

  def get_borrower(book_id)
    @borrower_hash[book_id].name
  end

  def available_books
    available_books = []  
    @books.each do |library_book|
      if library_book.status == "available"
        available_books << library_book
      end
    end
    return available_books

      # @books.map do |library_book|
      #   if library_book.status == "available"
      #     library_book
      #   end
      # end
  end

  def borrowed_books
    checked_out = []
    @books.each do |library_book|
      if library_book.status == "checked_out"
        checked_out << library_book
      end
    end
    return checked_out
  end
end
