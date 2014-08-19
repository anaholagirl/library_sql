require 'pg'
require './lib/Books.rb'
require './lib/author.rb'
require './lib/patron.rb'

DB = PG.connect({:dbname => 'books'})

def main_menu
  loop do
    puts "Press 'l' if you are a library staff"
    puts "Press 'p' if you are a library patron"
    puts "Press 'x' to exit"

    menu_choice = gets.chomp.downcase

    if menu_choice == 'l'
      staff_menu
    elsif menu_choice == 'p'
      patron_menu
    elsif menu_choice == 'x'
      puts "Good-bye!"
      exit
    else
      puts "The option you entered is not a valid option.  Please choose again."
      main_menu
    end
  end
end

def staff_menu
  loop do
    puts "Press 'l' to list all books in the catalog"
    puts "Press 'a' to add a book"
    puts "Press 'p' to list all patrons"
    puts "Press 'c' to check out a book"
    puts "Press 'n' to add new copies of a book"
    puts "Press 'ft' to find a book by its title"
    puts "Press 'fa' to find a book by its author"
    puts "Press 'm' to return to main menu"

    menu_choice = gets.chomp.downcase

    if menu_choice == 'l'
      list_books
    elsif menu_choice == 'a'
      add_book
    elsif menu_choice == 'p'
      list_patrons
    elsif menu_choice == 'c'
      checkout_book
    elsif menu_choice == 'n'
      add_copies
    elsif menu_choice == 'ft'
      find_title
    elsif menu_choice == 'fa'
      find_author
    elsif menu_choice == 'm'
      main_menu
    else
      puts "Did not understand entry.  Please enter a valid option."
    end
  end
end
def patron_menu
  loop do
    puts "Press 'r' to register as a patron"
    puts "Press 'c' to check out a book"
    puts "Press 'ft' to find a book by its title"
    puts "Press 'fa' to find a book by its author"
    puts "Press 'm' to return to main_menu"

    menu_choice = gets.chomp.downcase

    if menu_choice == 'r'
      add_patron
    elsif menu_choice == 'c'
      checkout_book
    elsif menu_choice == 'ft'
      find_title
    elsif menu_choice == 'fa'
      find_author
    elsif menu_choice == 'm'
      main_menu
    else
      puts "Did not understand entry.  Please enter a valid option."
    end
  end
end


def list_books
  Books.all.each do |book|
    puts book.name
  end
end

def add_book
  puts "Please enter the title of the book."
  title = gets.chomp
  puts "Please enter the author of the book."
  author = gets.chomp
  new_book = Books.new({:name => title, :author => author})
  new_book.save
  puts "Your book has been added."
end

def list_patrons
  Patrons.all.each do |patron|
    puts patron.name
  end
end

def find_title
  puts "What is the title you are searching for?"
  title = gets.chomp
  results = Books.find_by_name(title)
  puts "\n\n"
  puts results[0].to_s + " has been found"
end

def find_author
  puts "What author are you searching for?"
  author = gets.chomp
  results = Books.find_by_author(author)
  puts "\n\n"
  puts "Here are the books by " + author
  results.each do |result|
    puts result.to_s
  end
end

def checkout_book
  puts "What is the title of the book you would like to check out?"
  book = gets.chomp
  puts "Please enter the Patron ID"
  id = gets.chomp
  book.checkout(id)
  puts "Thank you"
  results = book.get_copies
  puts "There are these many copies left: " + results.to_s
end
main_menu
