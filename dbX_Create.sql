--------------------------create database (�n�bC��Ф@�Ӹ�dbX��Ƨ�)---------------------
--drop database if exists dbX

--create database dbX
--on primary
--	(name= 'dbX', filename= 'C:\dbX\dbX.mdf',
--	size= 8MB, maxsize= unlimited, filegrowth = 4MB),
--filegroup secondary 
--	(name = 'dbX_ndf', filename = 'C:\dbX\dbX_ndf.ndf',
--	size = 8MB, maxsize = unlimited)
--log on
--	(name = 'dbX_Idf', filename = 'C:\dbX\Idf.dbX_Idf',
--	size = 8MB, maxsize = 2GB, filegrowth = 4Mb)
--go

--create schema XXX;   --���c�y�z
--go

------------------------Create table-----------------------------------------------
use dbX
-----------------------Managers OK

drop table if exists Managers
create table Managers(
		ManagerID int identity(1,1),
		Name nvarchar(50),
		Email nvarchar(50),
		Phone nvarchar(50),
		Password nvarchar(50),
		constraint UQ_Managers_Email unique (Email),
		constraint UQ_Managers_Phone unique (Phone),
		constraint PK_Managers primary key(ManagerID));
go
-----------------------Customers OK

drop table if exists Customers        
Create table Customers(
		CustomerID int identity(1,1),
		Name nvarchar(50),
		Email nvarchar(50),
		Phone nvarchar(50),
		Password nvarchar(50),
		Address nvarchar(50),
		Birth datetime,
		CreditCard nvarchar(50),
		CreditPoints int,
		BlackListed bit default 0,
		constraint UQ_Customers_Email unique (Email),
		constraint UQ_Customers_Phone unique (Phone),
		constraint UQ_Customers_CreditCard unique (CreditCard),
		constraint PK_Customers primary key clustered (CustomerID asc))
go
-----------------------Suppliers OK

drop table if exists Suppliers
Create table Suppliers(
		SupplierID int identity(1,1),
		Category nvarchar(50),
		Name nvarchar(50),
		Email nvarchar(50),
		Phone nvarchar(50),
		Password nvarchar(50),
		Address nvarchar(50),
		CreditPoints int,
		BlackListed bit,
		constraint UQ_Suppliers_Email unique (Email),
		constraint UQ_Suppliers_Phone unique (Phone),
		constraint PK_Suppliers primary key(SupplierID),
		);
go
-----------------------Products OK

drop table if exists Products
Create table Products(
		ProductID int identity(1,1),
		SupplierID int,
		Name nvarchar(50),
		UnitPrice int,
		Image nvarchar(50),
		constraint UQ_Products_Image unique (Image),
		constraint PK_Products primary key (ProductID asc),
		constraint FK_Products_Suppliers foreign key(SupplierID)
		references dbX.dbo.Suppliers(SupplierID)
		on delete cascade
		on update cascade)
go
-----------------------COrders OK

drop table if exists COrders
create table COrders(
		OrderID int identity(1,1),
		CustomerID int,
		ProductID int,
		OrderDate datetime default sysdatetime() not null,     --�w�]�ثe���t�ήɶ�
		ReturnDate datetime,                                     --�w�w�k�٤��(��ʹq�����~)
		CancelDate datetime,
		TakeDate datetime,
		EndDate datetime,
		Status nvarchar(50),
		Quantity int,
		Price money,
		Code nvarchar(50),
		constraint PK_COrders primary key(OrderID),
		constraint FK_COrders_Customers foreign key(CustomerID)
		references dbX.dbo.Customers(CustomerID)
		on delete cascade
		on update cascade,
		constraint FK_COrders_Products foreign key(ProductID)
		references dbX.dbo.Products(ProductID)
		on delete cascade
		on update cascade
		);
go

-----------------------PSite OK

drop table if exists PSite
Create table PSite(
		SiteID int identity(1,1),
		ProductID int,
		Name nvarchar(50),
		Address nvarchar(50),
		Latitude nvarchar(50),
		Longitude nvarchar(50),
		UnitOrPing int,
		UnitInStock int,
		Image nvarchar(50),
		Description nvarchar(500),
		constraint UQ_PSite_Image unique (Image),
		constraint PK_PSite primary key (SiteID asc),
		constraint FK_PSite_Products foreign key(ProductID)
		references dbX.dbo.Products(ProductID)
		on delete cascade
		on update cascade);
go
-----------------------Advertise OK

drop table if exists Advertise
create table Advertise(
		AdvertiseID int identity(1,1),
		Name nvarchar(50),
		UnitPrice int,
		constraint PK_Advertise primary key(AdvertiseID)
		);
go
-----------------------AOrders OK

drop table if exists AOrders
create table AOrders(
		AOrderID int identity(1,1),
		SupplierID int,
		AdvertiseID int,
		OrderDate datetime default sysdatetime() not null,     --�w�]�ثe���t�ήɶ�
		EndDate datetime,
		Clicks int,
		constraint PK_AOrders primary key(AOrderID),
		constraint FK_AOrders_Suppliers foreign key(SupplierID)
		references dbx.dbo.Suppliers(SupplierID)
		on delete cascade
		on update cascade,
		constraint FK_AOrders_Advertise foreign key(AdvertiseID)
		references dbx.dbo.Advertise(AdvertiseID)
		on delete cascade
		on update cascade);
go
-----------------------Evaluations OK

drop table if exists Evaluations
create table Evaluations(
		EvaluationID int identity(1,1),
		CustomerID int,
		ProductID int,
		Date datetime default sysdatetime(),     --�w�]�ثe���t�ήɶ�
		Title nvarchar(100),
		Description nvarchar(500),
		Response nvarchar(500),
		Star int,
		constraint PK_Evaluations primary key(EvaluationID),
		constraint FK_Evaluations_Customers foreign key(CustomerID)
		references dbX.dbo.Customers(CustomerID)
		on delete cascade
		on update cascade,
		constraint FK_Evaluations_Products foreign key(ProductID)
		references dbX.dbo.Products(ProductID)
		on delete cascade
		on update cascade);
go
-----------------------Coupons OK

drop table if exists Coupons
Create table Coupons(
		CouponID int identity(1,1),
		Code nvarchar(50),
		Discount money,            --�馩����5��(0.5)�B6��(0.6)�B79��(0.79)
		ExpiryDate datetime,
		Quantity int,
		Available bit,
		constraint UQ_Coupons_Code unique (Code),
		constraint PK_Coupons primary key (CouponID asc))
go
-----------------------CouponsLog OK

drop table if exists CouponsLog
Create table CouponsLog(
		CouponID int identity(1,1),
		OrderID int,
		constraint PK_CouponsLog primary key (CouponID asc,OrderID))
go