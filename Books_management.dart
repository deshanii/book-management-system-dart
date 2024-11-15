import 'dart:io';

enum BookStatus { 
  available, 
  borrowed 
  }

class Book {
  String _title;
  String _author;
  String _isbn;
  BookStatus _status;

  Book(this._title, this._author, this._isbn,
      [this._status = BookStatus.available]);

  String get getTitle {
    return this._title;
  }

  String get getAuthor {
    return this._author;
  }

  String get getIsbn {
    return this._isbn;
  }

  String get getStatus {
    return this._status.toString();
  }

  void set setTitle(String newTitle) {
    this._title = newTitle;
  }

  void set setAuthor(String newAuthor) {
    this._author = newAuthor;
  }

  void set setIsbn(String newIsbn) {
    this._isbn = newIsbn;
  }

  void set setStatus(BookStatus newStatus) {
    this._status = newStatus;
  }

  void updateStatus(BookStatus newStatus) {
    this._status = newStatus;
  }

  String toString() {
    return 'Title: $_title, Author: $_author, ISBN: $_isbn, Status: $_status';
  }
}

class TextBook extends Book {
  String _subject;
  int _gradeLevel;

  TextBook(
      String title, String author, String isbn, this._subject, this._gradeLevel,
      [BookStatus status = BookStatus.available])
      : super(title, author, isbn, status);

  String get getSubject {
    return this._subject;
  }

  int get getGradeLevel {
    return this._gradeLevel;
  }

  void set setSubject(String newSubject) {
    this._subject = newSubject;
  }

  void set setGradeLevel(int newGradeLevel) {
    this._gradeLevel = newGradeLevel;
  }

  String toString() {
    return '${super.toString()}, Subject: $_subject, Grade Level: $_gradeLevel';
  }
}

class BookManagementSystem {
  List<Book> books = [];
  bool isValidISBN(String isbn) {
    if (isbn.length != 13) {
      return false;
    }
    for (int i = 0; i < isbn.length; i++) {
      if (!isNumeric(isbn[i])) {
        return false;
      }
    }
    return true;
  }

  bool isNumeric(String str) {
    return int.tryParse(str) != null;
  }

  bool isDuplicateISBN(String isbn) {
    for (var book in books) {
      if (book.getIsbn == isbn) {
        return true;
      }
    }
    return false;
  }

  void addRegularBook() {
    print("\nEnter Regular Book Details:");
    print("Enter title:");
    String title = stdin.readLineSync() ?? "";
    print("Enter author:");
    String author = stdin.readLineSync() ?? "";
    String isbn;
    while (true) {
      print("Enter ISBN (13 digits):");
      isbn = stdin.readLineSync() ?? "";
      if (!isValidISBN(isbn)) {
        print("Invalid ISBN. Please re-enter a valid 13-digit ISBN.");
        continue;
      }
      if (isDuplicateISBN(isbn)) {
        print(
            "A book with this ISBN already exists. Please enter a unique ISBN.");
        continue;
      }
      break;
    }
    var book = Book(title, author, isbn);
    books.add(book);
    print('Book added successfully');
  }

  void addTextBook() {
    print("\nEnter TextBook Details:");
    print("Enter title:");
    String title = stdin.readLineSync() ?? "";
    print("Enter author:");
    String author = stdin.readLineSync() ?? "";
    String isbn;
    while (true) {
      print("Enter ISBN (13 digits):");
      isbn = stdin.readLineSync() ?? "";
      if (!isValidISBN(isbn)) {
        print("Invalid ISBN. Please re-enter a valid 13-digit ISBN.");
        continue;
      }
      if (isDuplicateISBN(isbn)) {
        print(
            "A book with this ISBN already exists. Please enter a unique ISBN.");
        continue;
      }
      break;
    }
    print("Enter subject:");
    String subject = stdin.readLineSync() ?? "";
    print("Enter grade level:");
    int gradeLevel = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
    var textbook = TextBook(title, author, isbn, subject, gradeLevel);
    books.add(textbook);
    print('TextBook added successfully.');
  }

  void searchByTitle() {
    print("\nEnter title to search:");
    String searchTitle = stdin.readLineSync() ?? "";
    List<Book> foundBooks = [];
    for (var book in books) {
      if (book.getTitle.toLowerCase().contains(searchTitle.toLowerCase())) {
        foundBooks.add(book);
      }
    }
    if (foundBooks.isEmpty) {
      print("No books found with that title.");
    } else {
      print("\nFound Books:");
      for (var book in foundBooks) {
        print(book);
      }
    }
  }

  void searchByAuthor() {
    print("\nEnter author name to search:");
    String searchAuthor = stdin.readLineSync() ?? "";
    List<Book> foundBooks = [];
    for (var book in books) {
      if (book.getAuthor.toLowerCase().contains(searchAuthor.toLowerCase())) {
        foundBooks.add(book);
      }
    }
    if (foundBooks.isEmpty) {
      print("No books found by that author.");
    } else {
      print("\nFound Books:");
      for (var book in foundBooks) {
        print(book);
      }
    }
  }

  void removeBook() {
    print("\nEnter ISBN of book to remove:");
    String isbn = stdin.readLineSync() ?? "";
    bool bookRemoved = false;
    for (int i = 0; i < books.length; i++) {
      if (books[i].getIsbn == isbn) {
        books.removeAt(i);
        bookRemoved = true;
        print('Book removed successfully');
        break;
      }
    }
    if (!bookRemoved) {
      print('No book found with that ISBN.');
    }
  }

  void updateBookStatus() {
    print("\nEnter ISBN of book to update status:");
    String isbn = stdin.readLineSync() ?? "";
    Book? foundBook;
    for (var book in books) {
      if (book.getIsbn == isbn) {
        foundBook = book;
        break;
      }
    }
    if (foundBook == null) {
      print("Book not found!");
      return;
    }
    print("Current status: ${foundBook.getStatus}");
    print("Enter new status (0 for available, 1 for borrowed):");
    String choice = stdin.readLineSync() ?? "";
    if (choice == "0") {
      foundBook.setStatus = BookStatus.available;
      print("Status updated to available.");
    } else if (choice == "1") {
      foundBook.setStatus = BookStatus.borrowed;
      print("Status updated to borrowed.");
    } else {
      print("Invalid choice!");
    }
  }

  void displayAllBooks() {
    if (books.isEmpty) {
      print('\nNo books in the system');
      return;
    }
    print('\nAll Books:');
    for (var book in books) {
      print(book);
    }
  }
}

void printWelcomeMessage() {
  print("\n");
  print(r"""
  /$$$$$$$                      /$$             /$$      /$$                                                                                       /$$            /$$$$$$                        /$$                             
  | $$__  $$                    | $$            | $$$    /$$$                                                                                      | $$           /$$__  $$                      | $$                             
  | $$  \ $$  /$$$$$$   /$$$$$$ | $$   /$$      | $$$$  /$$$$  /$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$/$$$$   /$$$$$$  /$$$$$$$  /$$$$$$        | $$  \__/ /$$   /$$  /$$$$$$$ /$$$$$$    /$$$$$$  /$$$$$$/$$$$ 
  | $$$$$$$  /$$__  $$ /$$__  $$| $$  /$$/      | $$ $$/$$ $$ |____  $$| $$__  $$ |____  $$ /$$__  $$ /$$__  $$| $$_  $$_  $$ /$$__  $$| $$__  $$|_  $$_/        |  $$$$$$ | $$  | $$ /$$_____/|_  $$_/   /$$__  $$| $$_  $$_  $$ 
  | $$__  $$| $$  \ $$| $$  \ $$| $$$$$$/       | $$  $$$| $$  /$$$$$$$| $$  \ $$  /$$$$$$$| $$  \ $$| $$$$$$$$| $$ \ $$ \ $$| $$$$$$$$| $$  \ $$  | $$           \____  $$| $$  | $$|  $$$$$$   | $$    | $$$$$$$$| $$ \ $$ \ $$ 
  | $$  \ $$| $$  | $$| $$  | $$| $$_  $$       | $$\  $ | $$ /$$__  $$| $$  | $$ /$$__  $$| $$  | $$| $$_____/| $$ | $$ | $$| $$_____/| $$  | $$  | $$ /$$       /$$  \ $$| $$  | $$ \____  $$  | $$ /$$| $$_____/| $$ | $$ | $$ 
  | $$$$$$$/|  $$$$$$/|  $$$$$$/| $$ \  $$      | $$ \/  | $$|  $$$$$$$| $$  | $$|  $$$$$$$|  $$$$$$$|  $$$$$$$| $$ | $$ | $$|  $$$$$$$| $$  | $$  |  $$$$/      |  $$$$$$/|  $$$$$$$ /$$$$$$$/  |  $$$$/|  $$$$$$$| $$ | $$ | $$ 
  |_______/  \______/  \______/ |__/  \__/      |__/     |__/ \_______/|__/  |__/ \_______/ \____  $$ \_______/|__/ |__/ |__/ \_______/|__/  |__/   \___/         \______/  \____  $$|_______/    \___/   \_______/|__/ |__/ |__/ 
                                                                                          /$$  \ $$                                                                       /$$  | $$                                            
                                                                                         |  $$$$$$/                                                                      |  $$$$$$/                                            
                                                                                          \______/                                                                        \______/                                              
  """);
}

void displayMenu() {
  print("\n1. Add Regular Book");
  print("2. Add TextBook");
  print("3. Remove Book");
  print("4. Search by Title");
  print("5. Search by Author");
  print("6. Update Book Status");
  print("7. Display All Books");
  print("8. Exit");
  print("Enter your choice (1-8):");
}

void main() {
  printWelcomeMessage();
  var library = BookManagementSystem();
  while (true) {
    displayMenu();
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        library.addRegularBook();
        break;
      case "2":
        library.addTextBook();
        break;
      case "3":
        library.removeBook();
        break;
      case "4":
        library.searchByTitle();
        break;
      case "5":
        library.searchByAuthor();
        break;
      case "6":
        library.updateBookStatus();
        break;
      case "7":
        library.displayAllBooks();
        break;
      case "8":
        print("\nThank you for using Book Management System!");
        return;
      default:
        print("\nInvalid choice! Please try again.");
    }
  }
}