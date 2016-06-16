require 'csv'

class BooksController < ApplicationController
    class Book
        attr_accessor :id, :title, :year, :link, :price

        def initialize(id, title, year, link, price)
            @id = id
            @title = title
            @year = year
            @link = link
            @price = price
        end
    end

    def list
        @books = fetch_books
    end

    def detail
        @books = fetch_books

        @book = @books.find { |b| b.id == params[:id] }
    end

    def edit
        @books = fetch_books

        @book = @books.find { |b| b.id == params[:id] }
    end

    def fetch_books
        books = []

        CSV.foreach("#{Rails.root}/books.csv", headers: true) do |row|
            the_hash      = row.to_hash
            id            = the_hash['id']
            title         = the_hash['title']
            year          = the_hash['year']
            link          = the_hash['link']
            price         = the_hash['price']
            book  = Book.new id, title, year, link, price
            books << book
        end

        books


    end
end
