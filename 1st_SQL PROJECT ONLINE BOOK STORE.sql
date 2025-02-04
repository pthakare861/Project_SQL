


CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'D:\Power Bi course 30 days\Data anaytics SQL lang micro course\drive-download-20250202T051039Z-001\Books.csv' 
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:\Power Bi course 30 days\Data anaytics SQL lang micro course\drive-download-20250202T051039Z-001\Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\Power Bi course 30 days\Data anaytics SQL lang micro course\drive-download-20250202T051039Z-001\Orders.csv' 
CSV HEADER;


-- 1) Retrieve all books in the "Fiction" genre:
	  SELECT * FROM Books
	  Where Genre='Fiction';
 

-- 2) Find books published after the year 1950:
			SELECT * FROM Books
			where Published_year>1950;

-- 3) List all customers from the Canada:
	 SELECT * FROM customers
	 WHERE Country='Canada';

-- 4) Show orders placed in November 2023:
		SELECT * FROM Orders
		WHERE Order_date between '2023-11-01' AND '2023-11-30';


-- 5) Retrieve the total stock of books available:
	Select sum(stock) as Total_stock
	from Books;



-- 6) Find the details of the most expensive book:
	Select * from Books
	ORDER by Price desc limit 1;
	


-- 7) Show all customers who ordered more than 1 quantity of a book:
	select * from Orders
	where quantity>1;


-- 8) Retrieve all orders where the total amount exceeds $20:
	Select * from Orders
	Where total_amount>20;



-- 9) List all genres available in the Books table:
	Select Distinct genre From Books;

-- 10) Find the book with the lowest stock:
	Select * from Books Order by stock limit 1;

-- 11) Calculate the total revenue generated from all orders:
		Select sum(total_amount) as revenue
		from Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
		SELECT B.GENRE, SUM(O.QUANTITY) AS TOTAL_BOOKS_SOLD
		FROM ORDERS O
		JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
		GROUP BY B.GENRE;



-- 2) Find the average price of books in the "Fantasy" genre:
	 SELECT AVG(PRICE) AS AVERAGE_PRICE
	 FROM BOOKS
	 WHERE GENRE = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
	select customer_Id, count(order_Id) as order_count
	from Orders
	group by customer_id
	Having count(order_id)>=2;




-- 4) Find the most frequently ordered book:
	 select Book_ID, count(order_id) as Order_count
	 from orders
	 Group by Book_id
	 Order by Order_count desc limit 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
 	SELECT * FROM BOOKS
	WHERE GENRE ='Fantasy'
	Order by price  desc limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
	 SELECT b.author, sum(o.quantity) as Total_Books_Sold
	 From orders o
	 Join books b ON o.book_id=b.book_id
	 Group by b.Author;






-- 7) List the cities where customers who spent over $30 are located:
 	Select distinct c.city, total_amount
	 From orders o
	 join customers c on o.customer_id=c.customer_id
	 where o.total_amount>30;


-- 8) Find the customer who spent the most on orders:
	 Select c.customer_id, c.name, Sum(o.total_amount) As Total_spent
	 From orders o
	 Join customers c ON o. customer_id = c.customer_id
	 Group by c.customer_id, c.name
	 Order by Total_spent Desc Limit 1;


--9) Calculate the stock remaining after fulfilling all orders:
	Select b.book_id, b.title, b.stock, coalesce(sum(o.quantity),0) As order_quantity,
		b.stock- coalesce(sum(O.quantity),0) as Remaining_quantity
		from books b
		left join orders o ON b.book_id=o.book_id
		Group by b.book_id Order by b.book_id;


		---Finish 








