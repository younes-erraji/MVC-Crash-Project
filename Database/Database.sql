Create Database CRUD_MVC
GO
Use CRUD_MVC
Go
Create Table Category
(
  Category_ID VARCHAR(22) PRIMARY KEY,
  Category_Name VARCHAR(34) NOT NULL,
  Category_Products_Count int,

)
GO
Create Table Product
(
  Product_ID int IDENTITY(0, 1) PRIMARY KEY,
  Product_Name VARCHAR(34) NOT NULL,
  Product_Price money NOT NULL CHECK (Product_Price > 0.0),
  Product_Count int NOT NULL CHECK (Product_Count >= 0),
  Product_Category VARCHAR(22) FOREIGN KEY REFERENCES Category (Category_ID)
)
GO
Create TRIGGER TR_Category_Products_Count
On Products After INSERT
AS
  BEGIN
  DEClARE @Category VARCHAR(22)
  SELECT @Category = Product_Category
  FROM INSERTED
  UPDATE Category SET Category_Products_Count += 1
      WHERE Category_ID = @Category
END
GO
Create Table User
(
  user_ID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT newid(),
  username VARCHAR(22) UNIQUE NOT NULL,
  [password] NVARCHAR(22) not null,
  user_Type varchar(20) not null check(user_Type in ('Admin', 'Employee'))
)
GO
Create Table User_Info
(
  CIN varchar(10) Primary Key CHECK (CIN Like '^[0-9]{1,2}[A-z]{6,7}$'),
  First_Name varchar(22),
  Last_Name varchar(22),
  Username varchar(22) unique not null foreign Key References User (username)
)
GO
create Proc EncryptLogin
  @username varchar(22),
  @password nvarchar(22),
  @type varchar(20)
as
begin
  insert into [Login]
    (username, password, Type)
  values
    (@username, convert(nvarchar(22), HashBytes('MD5', @username + @password)), @type)
end
GO
Exec EncryptLogin 'younes', '123', 'Admin'
GO
Insert Into User_Info
Values
  ('AD2012013', 'Younes', 'ERRAJI', 'younes')
GO
create Function [dbo].[VerifyLogin]
(@username varchar(22),
@password nvarchar(22))
returns bit
as begin
  declare @i bit = 0
  if Exists (select username, password
  from User
  where convert(nvarchar(22), HashBytes('MD5', @username + @password)) = (select [password]
  from user
  where username = @username))
		set @i = 1
  else set @i = 0
  return @i
end
GO
select dbo.[VerifyLogin]('ilham', '123')
GO
select dbo.[VerifyLogin]('younes', '123')
GO