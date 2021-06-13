CREATE TABLE Users(
username VARCHAR(20),
password  VARCHAR(20),
first_name VARCHAR(20),
last_name VARCHAR(20),
email VARCHAR(50),
PRIMARY KEY(username) 
);

CREATE TABLE User_mobile_numbers(
mobile_number VARCHAR(20),
username VARCHAR(20),
PRIMARY KEY(mobile_number,username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE User_Address(
address VARCHAR(100),
username VARCHAR(20),
PRIMARY KEY(address,username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Customer(
username VARCHAR(20),
points int DEFAULT 0,
PRIMARY KEY(username) ,
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE  ON UPDATE CASCADE 
);

CREATE TABLE Admins (
username VARCHAR(20),
PRIMARY KEY(username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Vendor(
username VARCHAR(20),
activated BIT DEFAULT 0,
company_name VARCHAR(20),
bank_acc_no VARCHAR(20),
admin_username VARCHAR(20),
PRIMARY KEY(username),
FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(username) REFERENCES Users ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Delivery_Person(
username VARCHAR(20),
is_activated BIT,
PRIMARY KEY(username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Credit_Card(
number VARCHAR(20) ,
expiry_date DATETIME,
cvv_code INT,
PRIMARY KEY(number)
);

CREATE TABLE Delivery(
id INT IDENTITY,
type VARCHAR(20),
time_duration INT,
fees DECIMAL(5,3),
username  VARCHAR(20),
PRIMARY KEY(id),
FOREIGN KEY(username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Giftcard(
code VARCHAR(10) ,
expiry_date DATETIME,
amount INT,
username VARCHAR(20),
PRIMARY KEY(code),
FOREIGN KEY(username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Orders(
order_no INT IDENTITY,
order_date DATETIME,
total_amount INT,
cash_amount DECIMAL(10,2),
credit_amount DECIMAL(10,3),
payment_type VARCHAR(20),
order_status VARCHAR(20) DEFAULT 'not processed',
remaining_days INT, 
time_limit VARCHAR(40), 
Gift_Card_code_used VARCHAR(10),
customer_name VARCHAR(20),
delivery_id INT,
creditCard_number VARCHAR(20),
PRIMARY KEY(order_no),
FOREIGN KEY(Gift_Card_code_used) REFERENCES GiftCard ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(delivery_id) REFERENCES Delivery ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(creditCard_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Product(
serial_no INT IDENTITY,
product_name VARCHAR(20),
category VARCHAR(20),
product_description TEXT,
price DECIMAL(10,2),
final_price DECIMAL(10,2),
color VARCHAR(20),
available BIT,
rate INT, 
vendor_username VARCHAR(20),
customer_username VARCHAR(20),
customer_order_id INT,
PRIMARY KEY(serial_no),
FOREIGN KEY(vendor_username) REFERENCES Vendor ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(customer_username) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(customer_order_id) REFERENCES Orders ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE CustomerAddstoCartProduct(
serial_no INT, 
customer_name VARCHAR(20),
PRIMARY KEY(serial_no,customer_name),
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Todays_Deals(
deal_id INT IDENTITY, 
deal_amount INT,
expiry_date DATETIME,
admin_username VARCHAR(20),
PRIMARY KEY(deal_id),
FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Todays_Deals_Product(
deal_id INT,
serial_no INT,
PRIMARY KEY(deal_id,serial_no),
FOREIGN KEY(deal_id) REFERENCES Todays_Deals ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE offer(
offer_id INT IDENTITY,
offer_amount INT,
expiry_date DATETIME,
PRIMARY KEY(offer_id)
);

CREATE TABLE offersOnProduct(
offer_id INT,
serial_no INT,
PRIMARY KEY(offer_id,serial_no),
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(offer_id) REFERENCES  offer ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Customer_Question_Product(
serial_no INT,
customer_name VARCHAR(20),
question VARCHAR(50),
answer TEXT,
PRIMARY KEY(serial_no,customer_name),
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Wishlist(
username VARCHAR(20),
name VARCHAR(20),
PRIMARY KEY(username,name),
FOREIGN KEY(username) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
);



CREATE TABLE Wishlist_Product(
username VARCHAR(20),
wish_name VARCHAR(20),
serial_no INT,
PRIMARY KEY(username,wish_name,serial_no),
FOREIGN KEY(username,wish_name) REFERENCES WishList ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Admin_Customer_Giftcard(
code VARCHAR(10),
customer_name VARCHAR(20),
admin_username VARCHAR(20),
remaining_points INT,
PRIMARY KEY(code,customer_name,admin_username),
FOREIGN KEY(code) REFERENCES GiftCard ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Admin_Delivery_Order(
delivery_username VARCHAR(20),
order_no INT,
admin_username VARCHAR(20),
delivery_window VARCHAR(50) ,
PRIMARY KEY(delivery_username,order_no),
FOREIGN KEY(delivery_username) REFERENCES Delivery_Person ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(order_no) REFERENCES Orders ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Customer_CreditCard(
customer_name VARCHAR(20),
cc_number VARCHAR(20),
PRIMARY KEY(customer_name,cc_number),
FOREIGN KEY(customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(cc_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE
);
GO

CREATE PROC customerRegister
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name	VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS
INSERT INTO Users(username,password,first_name,last_name,email) 
values(@username,@password,@first_name,@last_name,@email)
INSERT INTO Customer(username,points)
VALUES(@username,0)
GO

CREATE PROC vendorRegister 
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name	VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50),
@company_name VARCHAR(20),
@bank_acc_no VARCHAR(20)
AS
INSERT INTO Users(username,password,first_name,last_name,email) 
VALUES(@username,@password,@first_name,@last_name,@email)
INSERT INTO Vendor(username,company_name,bank_acc_no)
VALUES(@username,@company_name,@bank_acc_no)
GO

CREATE PROC userLogin 
@username VARCHAR(20),
@password VARCHAR(20),
@success BIT OUTPUT,
@type INT OUTPUT
AS
SET @success = 0
IF(EXISTS(SELECT *
			FROM Customer C
			INNER JOIN Users U 
			ON C.username LIKE U.username
			WHERE (U.username LIKE @username) AND (U.password LIKE @password)))
BEGIN 
SET @success = 1 
SET @type = 0 
END 
ELSE 
BEGIN 
IF(EXISTS(SELECT *
			FROM Vendor V
			INNER JOIN Users U 
			ON V.username LIKE U.username
			WHERE (U.username LIKE @username) AND (U.password = @password)))
BEGIN 
SET @success = 1
SET @type = 1 
END 
ELSE 
BEGIN
IF(EXISTS(SELECT *
			FROM Admins A
			INNER JOIN Users U 
			ON A.username LIKE U.username
			WHERE (U.username LIKE @username) AND (U.password = @password)))
BEGIN 
SET @success = 1 
SET @type = 2 
END 
ELSE 
BEGIN 
IF(EXISTS(SELECT *
			FROM Delivery_Person DP
			INNER JOIN Users U 
			ON DP.username LIKE U.username
			WHERE (U.username LIKE @username) AND (U.password = @password)))
BEGIN 
SET @success = 1 
SET @type = 3 
END 
END
END
END
GO

CREATE PROC addMobile 
@username VARCHAR(20),
@mobile_number VARCHAR(20)
AS
INSERT INTO User_mobile_numbers(mobile_number,username)
VALUES(@mobile_number,@username)
GO

CREATE PROC addAddress 
@username varchar(20),
@address varchar(100)
AS
INSERT INTO User_Address(address,username)
VALUES(@address,@username)
GO

CREATE PROC showProducts
AS
SELECT product_name,product_description,price,final_price,color
FROM Product
WHERE available = 1
GO

CREATE PROC	ShowProductsbyPrice
AS
SELECT product_name,product_description,price,final_price,color
FROM Product 
WHERE available = 1
ORDER BY final_price ASC
GO

CREATE PROC searchbyname 
@text VARCHAR(20)
AS
SELECT product_name,product_description,price,final_price,color
FROM Product 
WHERE ((product_name LIKE @text) OR (category LIKE @text) OR (color LIKE @text)) AND available =1
GO

CREATE PROC AddQuestion
@serial INT,
@customer VARCHAR(20),
@Question VARCHAR(50)
AS
INSERT INTO Customer_Question_Product(serial_no,customer_name,question)
values(@serial,@customer,@Question)
GO

CREATE PROC addToCart
@customername VARCHAR(20),
@serial int
AS
INSERT INTO CustomerAddstoCartProduct(serial_no,customer_name)
VALUES(@serial,@customername)
GO

CREATE PROC removefromCart
@customername VARCHAR(20),
@serial INT
AS
DELETE FROM CustomerAddstoCartProduct
WHERE (customer_name LIKE @customername) AND (serial_no = @serial)
GO

CREATE PROC createWishlist
@customername VARCHAR(20), 
@name VARCHAR(20)
AS
INSERT INTO Wishlist(username,name)
VALUES(@customername,@name)
GO

CREATE PROC AddtoWishlist
@customername VARCHAR(20),
@wishlistname VARCHAR(20), 
@serial INT
AS
INSERT INTO Wishlist_Product(username,wish_name,serial_no)
VALUES(@customername,@wishlistname,@serial)
GO

CREATE PROC removefromWishlist
@customername VARCHAR(20),
@wishlistname VARCHAR(20), 
@serial INT
AS
DELETE FROM  Wishlist_Product
WHERE(username LIKE @customername) AND (wish_name LIKE @wishlistname) AND (serial_no = @serial)
GO

CREATE PROC showWishlistProduct
@customername VARCHAR(20),
@name VARCHAR(20)
AS
SELECT P.product_name,P.product_description,P.price,P.final_price,P.color
FROM Product P
INNER JOIN Wishlist_Product WP 
ON p.serial_no = WP.serial_no
GO

CREATE PROC viewMyCart
@customer VARCHAR(20)
AS
SELECT P.product_name,P.product_description,P.price,P.final_price,P.color
FROM Product P
INNER JOIN CustomerAddstoCartProduct CP
ON p.serial_no = CP.serial_no
WHERE CP.customer_name LIKE @customer 
GO

CREATE PROC calculatepriceOrder 
@customername VARCHAR(20),
@sum DECIMAL(10,2) OUTPUT
AS
SELECT @sum= SUM(P.final_price)
FROM PRODUCT P
INNER JOIN CustomerAddstoCartProduct CP 
ON P.serial_no = CP.serial_no
WHERE CP.customer_name = @customername
GO

CREATE PROC emptyCart
@customername VARCHAR(20)
AS
DELETE FROM  CustomerAddstoCartProduct
WHERE customer_name LIKE @customername
GO


CREATE PROC makeOrder
@customername VARCHAR(20),
@orderid VARCHAR(20) OUTPUT,
@totalamount DECIMAL(10,2) OUTPUT
AS
DECLARE @sum DECIMAL(10,2)
EXEC calculatepriceOrder @customername,@sum OUTPUT
INSERT INTO Orders(customer_name,total_amount,order_date)
VALUES(@customername,@sum,CURRENT_TIMESTAMP)
DECLARE @id INT
SELECT @id=max(order_no)
FROM Orders
EXEC productsinorder @customername , @id
UPDATE Product 
SET customer_order_id = @id 
WHERE customer_username LIKE @customername
SET @orderid = @id 
SET @totalamount = @sum
GO

CREATE PROC productsinorder
@customername VARCHAR(20),
@orderID INT
AS
UPDATE  Product
SET available = 0,customer_username = @customername,customer_order_id = @orderID
WHERE serial_no IN (SELECT serial_no
FROM CustomerAddstoCartProduct 
WHERE customer_name = @customername)
DELETE FROM CustomerAddstoCartProduct 
WHERE serial_no IN (SELECT serial_no
FROM CustomerAddstoCartProduct 
WHERE customer_name = @customername)
SELECT P.*
FROM Product P 
INNER JOIN Orders O
ON P.customer_order_id = O.order_no
WHERE (O.customer_name LIKE @customername) AND (O.order_no = @orderID)
GO

CREATE PROC cancelOrder 
@orderid INT
AS
DECLARE @points INT
DECLARE @price INT
DECLARE @giftcard VARCHAR(20)
DECLARE @username VARCHAR(20)
DECLARE @date DATETIME
DECLARE @creditamount DECIMAL(10,2)
DECLARE @cashamount DECIMAL(10,2)


SELECT @giftcard=Gift_Card_code_used,@username=customer_name 
FROM Orders 
WHERE order_no=@orderid
SET @points=0
SELECT @price=total_amount,@creditamount=credit_amount,@cashamount=cash_amount 
FROM Orders 
WHERE order_no=@orderid
SELECT @date=expiry_date 
FROM Giftcard 
where code=@giftcard
IF EXISTS(SELECT O.* 
		  FROM Orders O 
		  WHERE order_no=@orderid AND (order_status='not processed' OR order_status='in proccess'))
BEGIN
IF ( (@giftcard is NOT NULL) AND (CURRENT_TIMESTAMP<=@date) )
BEGIN 
IF(@creditamount IS NULL)
BEGIN
IF(@cashamount IS NULL)
SET @points=@price
ELSE
SET @points=@price-@cashamount
END
ELSE
BEGIN
SET @points=@price-@creditamount
END
UPDATE Customer 
SET points=@points+points 
WHERE username=@username
UPDATE Admin_Customer_Giftcard 
SET remaining_points=remaining_points+@points
WHERE code=@giftcard
END
UPDATE Product 
SET customer_username =NULL, customer_order_id=NULL, available=1
WHERE customer_order_id=@orderid
DELETE FROM Orders WHERE order_no=@orderid
END
GO

CREATE PROC returnProduct
@serialno INT, 
@orderid INT
AS
DECLARE @total_amount DECIMAL(10,2)
DECLARE @cash_amount DECIMAL(10,2)
DECLARE @credit_amount DECIMAL(10,2)
SET @cash_amount = 0 
SET @credit_amount = 0
SELECT @cash_amount = cash_amount
FROM Orders
WHERE (order_no = @orderID) AND (cash_amount IS NOT NULL)
SELECT @credit_amount = credit_amount
FROM Orders
WHERE (order_no = @orderID) AND (credit_amount IS NOT NULL)
SELECT @total_amount = total_amount 
FROM Orders 
WHERE order_no = @orderid
UPDATE Product 
SET available = 1, customer_username = NULL,customer_order_id=NULL
IF(((@cash_amount IS NOT NULL) AND (@cash_amount = @total_amount)) OR ((@credit_amount IS NOT NULL) AND (@credit_amount = @total_amount)))
BEGIN
UPDATE Orders 
SET total_amount = total_amount - (SELECT final_price
									FROM Product
									WHERE serial_no=@serialno)
WHERE order_no = @orderid
END 
ELSE
BEGIN 
IF(@cash_amount <@total_amount)
BEGIN 
IF((SELECT expiry_date
   FROM Giftcard G 
   INNER JOIN Orders O 
   ON G.code=O.Gift_Card_code_used
   WHERE O.order_no = @orderid) <= CURRENT_TIMESTAMP)
BEGIN
UPDATE Orders
SET total_amount = total_amount - (SELECT final_price
									FROM Product
									WHERE serial_no = @serialno)
WHERE order_no = @orderid
END
ELSE 
BEGIN 
UPDATE Customer 
SET points  = points + (@total_amount - (@cash_amount + @credit_amount))
WHERE username LIKE (SELECT customer_name
					 FROM Orders
					 WHERE order_no = @orderid)
UPDATE Admin_Customer_Giftcard
SET remaining_points = remaining_points + (@total_amount - (@cash_amount+@credit_amount))
WHERE code = (SELECT Gift_Card_code_used
			  FROM Orders
			  WHERE order_no = @orderid)
END 
END 
IF(@credit_amount <@total_amount)
BEGIN 
IF((SELECT expiry_date
   FROM Giftcard G 
   INNER JOIN Orders O 
   ON G.code=O.Gift_Card_code_used
   WHERE O.order_no = @orderid) <= CURRENT_TIMESTAMP)
BEGIN
UPDATE Orders
SET total_amount = total_amount - (SELECT final_price
									FROM Product
									WHERE serial_no = @serialno)
WHERE order_no = @orderid
END
ELSE 
BEGIN 
UPDATE Customer 
SET points  = points + (@total_amount - (@cash_amount + @credit_amount))
WHERE username LIKE (SELECT customer_name
					 FROM Orders
					 WHERE order_no = @orderid)
UPDATE Admin_Customer_Giftcard
SET remaining_points = remaining_points + (@total_amount - (@cash_amount+@credit_amount))
WHERE code = (SELECT Gift_Card_code_used
			  FROM Orders
			  WHERE order_no = @orderid)
END 
END 
ELSE 
BEGIN 
IF((SELECT expiry_date
   FROM Giftcard G 
   INNER JOIN Orders O 
   ON G.code=O.Gift_Card_code_used
   WHERE O.order_no = @orderid) <= CURRENT_TIMESTAMP)
BEGIN
UPDATE Orders
SET total_amount = total_amount - (SELECT final_price
									FROM Product
									WHERE serial_no = @serialno)
WHERE order_no = @orderid
END
ELSE 
BEGIN 
UPDATE Customer 
SET points  = points + (@total_amount - (@cash_amount + @credit_amount))
WHERE username LIKE (SELECT customer_name
					 FROM Orders
					 WHERE order_no = @orderid)
UPDATE Admin_Customer_Giftcard
SET remaining_points = remaining_points + (@total_amount - (@cash_amount+@credit_amount))
WHERE code = (SELECT Gift_Card_code_used
			  FROM Orders
			  WHERE order_no = @orderid)
END 
END
END
GO

CREATE PROC ShowproductsIbought 
@customername VARCHAR(20)
AS
SELECT P.* 
FROM Product P 
INNER JOIN Orders O 
ON P.customer_order_id = O.order_no
WHERE O.customer_name LIKE @customername
GO

CREATE PROC rate
@serialno INT,
@rate INT ,
@customername VARCHAR(20)
AS
EXEC ShowproductsIbought @customername
UPDATE Product 
SET rate = @rate 
WHERE serial_no = @serialno 
GO

CREATE PROC SpecifyAmount
@customername VARCHAR(20), 
@orderID int, 
@cash decimal(10,2), 
@credit decimal(10,2)
AS 
DECLARE @points int 
DECLARE @price DECIMAL(10,2)
SELECT @points
FROM Customer
WHERE username LIKE @customername
SELECT @price = total_amount
FROM ORDERS 
WHERE @orderID = order_no
IF(@credit IS NOT NULL)
BEGIN
SET @price = @price - @credit
END 
ELSE 
BEGIN 
IF(@cash IS NOT NULL)
BEGIN 
SET @price = @price - @cash
END 
END
UPDATE Admin_Customer_Giftcard
SET remaining_points = remaining_points - @price
WHERE customer_name = @customername
UPDATE Customer
SET points = @points - @price
WHERE username = @customername
UPDATE Orders 
SET cash_amount = @cash, credit_amount = @credit
WHERE order_no = @orderID
IF(@cash < (SELECT total_amount
			FROM Orders
			WHERE order_no = @orderID))
BEGIN 
UPDATE Orders
SET Gift_Card_code_used = (SELECT code 
							FROM Admin_Customer_Giftcard
							WHERE (customer_name LIKE @customername) and (order_no = @orderID))
END
GO 

CREATE PROC AddCreditCard 
@creditcardnumber VARCHAR(20),
@expirydate DATE ,
@cvv VARCHAR(4),
@customername VARCHAR(20)
AS
INSERT INTO Credit_Card
VALUES(@creditcardnumber,@expirydate,@cvv)
INSERT INTO Customer_CreditCard 
VALUES(@customername,@creditcardnumber)
GO

CREATE PROC ChooseCreditCard
@creditcard VARCHAR(20), 
@orderid INT 
AS
UPDATE Orders 
SET creditCard_number = @creditcard 
WHERE order_no = @orderid 
GO

CREATE PROC vewDeliveryTypes 
AS 
SELECT type 
FROM Delivery 
GO

CREATE PROC specifydeliverytype
@orderID int, 
@deliveryID int
AS 
DECLARE @time INT
SELECT @time = (SELECT time_duration
				FROM Delivery
				 WHERE id = @deliveryID)
UPDATE Orders
SET delivery_id = @deliveryID, remaining_days = @time
WHERE order_no = @orderID
GO

CREATE PROC trackRemainingDays 
@orderid INT,
@customername VARCHAR(20),
@days INT OUTPUT
AS
DECLARE @arrivedate DATETIME 
DECLARE @orderdate DATETIME
DECLARE @remdays INT 
SELECT @remdays = remaining_days , @orderdate = order_date  
FROM Orders
WHERE order_no = @orderid
SET @arrivedate = DATEADD(DAY,@remdays,@orderdate)
SET @days = DATEDIFF(DAY,CURRENT_TIMESTAMP,@arrivedate)
UPDATE Orders 
SET remaining_days = @days 
WHERE order_no = @orderid
SELECT @days=remaining_days
FROM Orders
WHERE order_no = @orderid
GO

CREATE PROC recommend
@customername VARCHAR(20)
AS
BEGIN
SELECT P1.*
FROM
(
SELECT TOP(3) P2.serial_no
FROM Wishlist_Product WP 
INNER JOIN Product P2 
ON WP.serial_no =P2.serial_no
WHERE P2.category 
IN
(
SELECT TOP(3) category 
FROM CustomerAddstoCartProduct CAP
INNER JOIN Product P3 
ON CAP.serial_no=P3.serial_no and CAP.customer_name=@customername
GROUP BY category
ORDER BY count(category) DESC
)
GROUP BY P2.serial_no
ORDER BY count(P2.serial_no) DESC
UNION
SELECT TOP(3) WP1.serial_no FROM (
SELECT TOP(3) CTC.customer_name
FROM CustomerAddstoCartProduct CTC 
INNER JOIN Product P4 
ON P4.serial_no=CTC.serial_no
WHERE CTC.customer_name!=@customername and P4.category 
IN
(
SELECT DISTINCT myP.category 
FROM Product myP 
INNER JOIN CustomerAddstoCartProduct myCC 
ON myCC.serial_no=myP.serial_no 
WHERE myCC.customer_name=@customername
)
GROUP BY CTC.customer_name
ORDER BY COUNT(DISTINCT P4.category) DESC
) AS TU 
INNER JOIN Wishlist_Product WP1 
ON TU.customer_name=WP1.username
GROUP BY WP1.serial_no
ORDER BY COUNT(WP1.serial_no) DESC
) AS TOUT
INNER JOIN Product P1 
ON P1.serial_no = TOUT.serial_no
END
GO

CREATE PROC postProduct
@vendorUsername VARCHAR(20),
@product_name VARCHAR(20) ,
@category VARCHAR(20),
@product_description TEXT ,
@price DECIMAL(10,2),
@color VARCHAR(20)
AS
INSERT INTO Product(vendor_username,product_name,category,product_description,price,color) 
VALUES(@vendorUsername,@product_name,@category,@product_description,@price,@color)
GO 

CREATE PROC vendorviewProducts
@vendorname VARCHAR(20)
AS
SELECT * 
FROM Product
WHERE vendor_username LIKE @vendorname
GO

CREATE PROC EditProduct
@vendorname VARCHAR(20),
@serialnumber INT,
@product_name VARCHAR(20) ,
@category VARCHAR(20),
@product_description TEXT ,
@price DECIMAL(10,2),
@color VARCHAR(20)
AS
UPDATE Product 
SET product_name = @product_name, category = @category, product_description = @product_description,price = @price , color =@color 
WHERE serial_no = @serialnumber AND vendor_username LIKE @vendorname
GO

CREATE PROC deleteProduct 
@vendorname VARCHAR(20),
@serialnumber INT
AS
DELETE FROM Product 
WHERE vendor_username LIKE @vendorname AND serial_no = @serialnumber 
GO

CREATE PROC viewQuestions 
@vendorname VARCHAR(20)
AS
SELECT Q.*
FROM Customer_Question_Product Q
INNER JOIN  PRODUCT P 
ON Q.serial_no  =P.serial_no 
WHERE P.vendor_username LIKE @vendorname 
GO

CREATE PROC answerQuestions
@vendorname VARCHAR(20),
@serialno INT,
@customername VARCHAR(20),
@answer TEXT 
AS
UPDATE Customer_Question_Product 
SET answer = @answer
WHERE serial_no = @serialno AND customer_name LIKE @customername 
GO

CREATE PROC addOffer 
@offeramount INT,
@expiry_date DATETIME
AS
INSERT INTO offer(offer_amount,expiry_date)
VALUES(@offeramount, @expiry_date)
GO

CREATE PROC checkOfferonProduct
@serial INT,
@activeoffer BIT OUTPUT
AS
IF(EXISTS(SELECT * 
			FROM offersOnProduct
			WHERE serial_no= @serial))
BEGIN 
SET @activeoffer=1 
END 
ELSE 
SET @activeoffer=0
GO


CREATE PROC checkandremoveExpiredoffer
@offerid INT
AS
DECLARE @exdate DATETIME
SELECT @exdate = expiry_date
FROM offer
WHERE offer_id=@offerid
IF(@exdate < CURRENT_TIMESTAMP)
BEGIN
UPDATE Product
SET final_price = price 
WHERE serial_no = (SELECT serial_no
					FROM offersOnProduct
					WHERE offer_id = @offerid)
DELETE FROM offer 
WHERE offer_id = @offerid AND expiry_date<CURRENT_TIMESTAMP
DELETE FROM offersOnProduct 
WHERE offer_id = @offerid
END
GO

CREATE PROC applyOffer
@vendorname VARCHAR(20), 
@offerid INT, 
@serial INT
AS
IF( NOT EXISTS( SELECT *
				FROM offersOnProduct
				WHERE (offer_id = @offerid) AND (serial_no = @serial)))
BEGIN 
INSERT INTO offersOnProduct(offer_id,serial_no)
VALUES(@offerid,@serial)
IF((SELECT final_price
	FROM Product
	WHERE serial_no = @serial) IS NOT NULL)
BEGIN
UPDATE Product
SET final_price = final_price - ((SELECT offer_amount
								  FROM offer
								  WHERE offer_id = @offerid)) 
WHERE (vendor_username LIKE @vendorname) AND (serial_no = @serial)
END
ELSE 
BEGIN
UPDATE Product
SET final_price = price - ((SELECT offer_amount
								  FROM offer
								  WHERE offer_id = @offerid))

END
END
GO

CREATE PROC activateVendors
@admin_username VARCHAR(20),
@vendor_username VARCHAR(20)
AS
UPDATE Vendor 
SET activated = 1 , admin_username =@admin_username
WHERE username like @vendor_username
GO

CREATE PROC inviteDeliveryPerson
@delivery_username VARCHAR(20), 
@delivery_email VARCHAR(50)
AS
INSERT INTO Users(username,email)
VALUES(@delivery_username,@delivery_email)
INSERT INTO Delivery_Person(username,is_activated)
VALUES(@delivery_username,0)
GO

CREATE PROC  reviewOrders
AS
SELECT * 
FROM Orders
GO

CREATE PROC updateOrderStatusInProcess
@order_no INT
AS
UPDATE Orders 
SET order_status = 'In process'
WHERE order_no = @order_no
GO

CREATE PROC addDelivery
@delivery_type VARCHAR(20),
@time_duration INT,
@fees DECIMAL(5,3),
@admin_username VARCHAR(20)
AS
INSERT INTO Delivery(type,time_duration,fees,username)
VALUES(@delivery_type,@time_duration,@fees,@admin_username)
GO

CREATE PROC  assignOrdertoDelivery 
@delivery_username VARCHAR(20),
@order_no INT,
@admin_username VARCHAR(20)
AS
INSERT INTO Admin_Delivery_Order(delivery_username,order_no,admin_username)
VALUES(@delivery_username,@order_no,@admin_username)
GO

CREATE PROC  createTodaysDeal 
@deal_amount INT,
@admin_username VARCHAR(20),
@expiry_date DATETIME 
AS
INSERT INTO Todays_Deals(deal_amount,admin_username,expiry_date)
VALUES(@deal_amount,@admin_username,@expiry_date)
GO

CREATE PROC  checkTodaysDealOnProduct
@serial_no INT,
@activeDeal BIT OUTPUT
AS
IF(EXISTS(SELECT *
			FROM Todays_Deals_Product
			WHERE serial_no=@serial_no))
BEGIN 
SET @activeDeal = 1
END 
ELSE 
SET @activeDeal = 0 
GO

CREATE PROC addTodaysDealOnProduct
@deal_id INT, 
@serial_no INT
AS
INSERT INTO Todays_Deals_Product(deal_id,serial_no)
VALUES(@deal_id,@serial_no)
GO

CREATE PROC removeExpiredDeal
@deal_iD INT
AS
DELETE FROM Todays_Deals
WHERE deal_id = @deal_iD AND expiry_date < CURRENT_TIMESTAMP
GO

CREATE PROC createGiftCard 
@code VARCHAR(10),
@expiry_date DATETIME,
@amount INT,
@admin_username VARCHAR(20)
AS
INSERT INTO Giftcard(code,expiry_date,amount,username)
VALUES(@code,@expiry_date,@amount,@admin_username)
GO

CREATE PROC removeExpiredGiftCard
@code VARCHAR(10)
AS
DELETE FROM Giftcard 
WHERE code LIKE @code AND expiry_date < CURRENT_TIMESTAMP
GO

CREATE PROC checkGiftCardOnCustomer
@code VARCHAR(10),
@activeGiftCard BIT OUTPUT
AS
IF(EXISTS(SELECT *
			FROM Admin_Customer_Giftcard
			WHERE code LIKE @code))
BEGIN
SET @activeGiftCard = 1
END 
ELSE 
SET @activeGiftCard = 0
GO 

CREATE PROC giveGiftCardtoCustomer
@code VARCHAR(10),
@customer_name VARCHAR(20),
@admin_username VARCHAR(20)
AS
DECLARE @points INT
SELECT @points=amount
FROM Giftcard
WHERE code LIKE @code
INSERT INTO Admin_Customer_Giftcard(code,customer_name,admin_username,remaining_points)
VALUES(@code,@customer_name,@admin_username,@points)
UPDATE Customer
SET points = points+@points
WHERE username LIKE @customer_name
GO

CREATE PROC acceptAdminInvitation
@delivery_username VARCHAR(20)
AS
UPDATE Delivery_Person
SET is_activated = 1
WHERE username LIKE @delivery_username
GO

CREATE PROC deliveryPersonUpdateInfo
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS
UPDATE Users 
SET first_name=@first_name,last_name=@last_name,password=@password,email=@email
WHERE username LIKE @username
GO

CREATE PROC viewmyorders 
@deliveryperson VARCHAR(20)
AS
SELECT O.*
FROM Orders O
INNER JOIN Admin_Delivery_Order AD
ON O.order_no = AD.order_no
WHERE AD.delivery_username LIKE @deliveryperson
GO

CREATE PROC specifyDeliveryWindow
@delivery_username VARCHAR(20),
@order_no INT,
@delivery_window VARCHAR(50)
AS
UPDATE Admin_Delivery_Order 
SET delivery_window = @delivery_window 
WHERE (delivery_username LIKE @delivery_username) AND (order_no = @order_no)
GO

CREATE PROC  updateOrderStatusOutforDelivery
@order_no INT
AS
UPDATE Orders 
SET order_status = 'Out for delivery'
WHERE order_no = @order_no
GO

CREATE PROC updateOrderStatusDelivered
@order_no INT
AS
UPDATE Orders 
SET order_status = 'Delivered'
WHERE order_no = @order_no
GO

INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('hana.aly','hana','aly','pass1','hana.aly@guc.edu.eg')

INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('ammar.yasser','ammar','yasser','pass4','ammar.yasser@guc.edu.eg')

INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('nada.sharaf','nada','sharaf','pass7','nada.sharaf@guc.edu.eg')

INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('hadeel.adel','hadeel','adel','pass13','hadeel.adel@guc.edu.eg')

INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('mohamed.tamer','mohamed','tamer','pass16','mohamed.tamer@guc.edu.eg')

INSERT INTO Admins(username)
VALUES('hana.aly')

INSERT INTO Admins(username)
VALUES('nada.sharaf')

INSERT INTO Customer(username,points)
VALUES('ammar.yasser',15)

INSERT INTO CustomerAddstoCartProduct(serial_no,customer_name)
VALUES(1,'ammar.yasser')

INSERT INTO Vendor(username,activated,company_name,bank_acc_no,admin_username)
VALUES('hadeel.adel',1,'Dello',47449349234,'hana.aly')

INSERT INTO Delivery_Person(is_activated,username)
VALUES(1,'mohamed.tamer')

INSERT INTO User_Address(address,username)
VALUES('New Cairo','hana.aly')

INSERT INTO User_Address(address,username)
VALUES('Heliopolis','hana.aly')

INSERT INTO User_mobile_numbers(mobile_number,username)
VALUES('01111111111','hana.aly')

INSERT INTO User_mobile_numbers(mobile_number,username)
VALUES('1211555411','hana.aly')

INSERT INTO Credit_Card(number,expiry_date,cvv_code)
VALUES('4444-5555-6666-8888','2028-10-19',232)

SET IDENTITY_INSERT Product ON;
INSERT INTO Product(serial_no,product_name,category,product_description,price,final_price,color,available,rate,vendor_username)
VALUES(1,'Bag','Fashion','backbag',100,100,'yellow',1,0,'hadeel.adel')

INSERT INTO Product(serial_no,product_name,category,product_description,price,final_price,color,available,rate,vendor_username)
VALUES(2,'Blue pen','stationary','useful pen',10,10,'Blue',1,0,'hadeel.adel')

INSERT INTO Product(serial_no,product_name,category,product_description,price,final_price,color,available,rate,vendor_username)
VALUES(3,'Blue pen','stationary','useful pen',10,10,'Blue',0,0,'hadeel.adel')
SET IDENTITY_INSERT Product OFF;

INSERT INTO Todays_Deals(deal_amount,admin_username,expiry_date)
VALUES(30,'hana.aly','2019-11-30')

INSERT INTO Todays_Deals(deal_amount,admin_username,expiry_date)
VALUES(40,'hana.aly','2019-11-18')

INSERT INTO Todays_Deals(deal_amount,admin_username,expiry_date)
VALUES(50,'hana.aly','2019-12-12')

INSERT INTO offer(offer_amount,expiry_date)
VALUES(50,'2019-11-30')

INSERT INTO Wishlist(username,name)
VALUES('ammar.yasser','fashion')

INSERT INTO Wishlist_Product(username,wish_name,serial_no)
VALUES('ammar.yasser','fashion',2)

INSERT INTO Giftcard(code,expiry_date,amount)
VALUES('G101','2019-11-18',100)

INSERT INTO Customer_CreditCard(customer_name,cc_number)
VALUES('ammar.yasser','4444-5555-6666-8888')

SELECT *
FROM Wishlist_Product








