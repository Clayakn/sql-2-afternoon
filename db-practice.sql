SELECT * from Invoice
JOIN Invoiceline ON Invoiceline.invoiceid = Invoice.invoiceid
WHERE UnitPrice > .99;

SELECT InvoiceDate, FirstName, LastName, Total from Invoice
JOIN Customer ON customer.customerid = Invoice.customerid;

SELECT c.FirstName, c.LastName, e.FirstName, e.LastName FROM Customer c
JOIN Employee e ON e.employeeid = c.SupportRepid;

SELECT title, ar.name FROM album
JOIN artist ar ON ar.artistid = album.artistid;

SELECT PlaylistTrack.TrackId from PlaylistTrack
JOIN Playlist ON Playlist.PlaylistId = PlaylistTrack.PlaylistId
WHERE Playlist.Name = "Music";

SELECT Track.Name from Track 
JOIN PlaylistTrack ON PlaylistTrack.TrackId = Track.TrackId 
WHERE PlaylistTrack.PlaylistId = 5;

SELECT Track.Name, Playlist.Name from Track 
JOIN PlaylistTrack ON PlaylistTrack.TrackId = Track.TrackId
JOIN Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId;

SELECT Track.Name, Album.Title from Track 
JOIN Genre ON Genre.GenreId = Track.GenreId
JOIN Album ON Album.AlbumId = Track.AlbumId 
WHERE Genre.Name = "Alternative";

SELECT * FROM Invoice 
WHERE InvoiceId IN (SELECT InvoiceId From InvoiceLine WHERE UnitPrice > .99);

SELECT * FROM PlaylistTrack 
WHERE PlaylistId IN (SELECT PlaylistId FROM Playlist WHERE name="Music");

SELECT track.name FROM Track
WHERE TrackId IN (SELECT TrackId FROM PlaylistTrack WHERE PlaylistId=5);

SELECT name FROM Track 
WHERE GenreId IN (SELECT GenreId FROM Genre WHERE Name="Comedy");

SELECT * FROM Track 
WHERE AlbumId IN (SELECT AlbumId FROM Album WHERE Name="Fireball");

SELECT * FROM Track 
WHERE AlbumId IN (SELECT AlbumId FROM Album WHERE ArtistId IN
(SELECT ArtistId FROM Artist WHERE Name="Queen"));

UPDATE customer
SET Fax = null
WHERE Fax IS NOT NULL;

UPDATE customer
SET Company = 'Self'
WHERE Company IS NULL;

UPDATE customer
SET LastName = 'Thompson'
WHERE FirstName = "Julia" AND LastName = "Barnett";

UPDATE customer
SET SupportRepId = 4
WHERE email = "luisrojas@yahoo.cl";

UPDATE Track 
SET Composer="The darkness around us"
WHERE GenreId IN (SELECT GenreId FROM Genre WHERE Name="Metal")
AND Composer IS NULL;

SELECT COUNT(*), Genre.name FROM Track
JOIN Genre ON Track.GenreId = Genre.GenreId
GROUP BY Genre.Name;

SELECT COUNT(*), Genre.name FROM Track
JOIN Genre ON Track.GenreId = Genre.GenreId
WHERE Genre.Name="Pop" OR Genre.Name='Rock'
GROUP BY Genre.Name;

SELECT COUNT(*), Artist.Name FROM Artist 
JOIN Album WHERE Album.ArtistId = Artist.ArtistId
GROUP BY album.ArtistId;

SELECT DISTINCT Composer FROM Track;
 
SELECT DISTINCT BillingPostalCode FROM Invoice;

SELECT DISTINCT Company FROM Customer; 

DELETE FROM practice_delete 
WHERE Type="bronze";

DELETE FROM practice_delete 
WHERE Type="silver";

DELETE FROM practice_delete
WHERE Value = 150;



---- E-Commerce Simulation

CREATE TABLE users (
ID SERIAL PRIMARY KEY,
NAME TEXT, 
EMAIL TEXT
);

CREATE TABLE products (
ID SERIAL PRIMARY KEY,
NAME TEXT,
PRICE DECIMAL
);

CREATE TABLE orders (
ID SERIAL PRIMARY KEY,
product_id INTEGER REFERENCES products (id)
);

INSERT INTO users
(NAME, EMAIL)
VALUES 
('Bob', 'gmail@bob.com'),
('Andy','gmail@andy.com'),
('Jenny','gmail@jenny.com');

INSERT INTO products
(NAME, PRICE)
VALUES 
('SpongeBob',2.34),
('Penny',5.68),
('Broom',6.52);

INSERT INTO orders 
(product_id)
VALUES
(2),
(1),
(3);

-- Get all products for the first order
SELECT * FROM products
JOIN orders ON orders.product_id = products.id
WHERE orders.id=1;

-- Get all orders 
SELECT * FROM orders;

-- Get the total cost of an order 
SELECT SUM(price) FROM products
JOIN orders ON orders.product_id = products.id
WHERE orders.id=2;

-- Add foreign key reference from Orders to Users 
ALTER TABLE orders
ADD COLUMN user_id INTEGER
REFERENCES users (id);


-- Update the Orders Table to link a user to each order
UPDATE orders 
SET user_id = 2
WHERE id = 1;

UPDATE orders 
SET user_id = 3
WHERE id = 2;

UPDATE orders 
SET user_id = 2
WHERE id = 3;

-- Get all orders for a user 
SELECT * FROM orders
WHERE user_id = 2;

-- Get how many orders each user has 
SELECT COUNT(*), users.name FROM orders
JOIN users ON users.id = orders.user_id
GROUP BY user_id;


-- Get the total amount on all orders for each user 
SELECT SUM(price), users.name FROM products
JOIN orders ON orders.product_id = products.id
JOIN users ON users.id = orders.user_id
GROUP BY user_id;