--------------------------create database (要在C曹創一個較dbX資料夾)---------------------
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

--create schema XXX;   --結構描述
--go

------------------------Create table-----------------------------------------------
use dbX
-----------------------Managers OK

drop table if exists Managers
create table Managers(
		ManagerID int identity(1,1),
		Name nvarchar(50) not null,
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
		Name nvarchar(50) not null,
		Sex bit,
		Email nvarchar(50),
		Phone nvarchar(50),
		Password nvarchar(50),
		Birth datetime,
		CreditCard nvarchar(50),
		CreditPoints int default 100,
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
		Name nvarchar(50) not null,
		Email nvarchar(50),
		Phone nvarchar(50),
		Password nvarchar(50),
		Address nvarchar(50),
		CreditPoints int default 100,
		BlackListed bit default 0,
		constraint UQ_Suppliers_Email unique (Email),
		constraint UQ_Suppliers_Phone unique (Phone),
		constraint PK_Suppliers primary key(SupplierID),
		);
go
-----------------------Category OK

drop table if exists Category
Create table Category(
		CategoryID int identity(1,1),
		Name nvarchar(50) not null,
		constraint PK_Category primary key (CategoryID asc))
go
-----------------------Products OK

drop table if exists Products
Create table Products(
		ProductID int identity(1,1),
		SupplierID int,
		Name nvarchar(50) not null,
		constraint PK_Products primary key (ProductID asc),
		constraint FK_Products_Suppliers foreign key(SupplierID)
		references dbX.dbo.Suppliers(SupplierID)
		on delete cascade
		on update cascade)
go
-----------------------PSite

drop table if exists PSite
Create table PSite(
		SiteID int identity(1,1),
		ProductID int,
		Name nvarchar(50) not null,
		Image nvarchar(50),
		OpenTime nvarchar(50),
		Latitude nvarchar(50),
		Longitude nvarchar(50),
		Address nvarchar(200),
		Description nvarchar(200),
		constraint PK_PSite primary key (SiteID asc),
		constraint FK_PSite_Products foreign key(ProductID)
		references dbX.dbo.Products(ProductID)
		on delete cascade
		on update cascade)
go
-----------------------PSiteRoom

drop table if exists PSiteRoom
Create table PSiteRoom(
		RoomID int identity(1,1),
		SiteID int,
		CategoryID int,
		HourPrice money,
		DatePrice money,
		Ping int,
		Image nvarchar(50),
		status bit default 0,
		Description nvarchar(200),
		constraint PK_PSiteRoom primary key (RoomID asc),
		constraint FK_PSiteRoom_PSite foreign key(SiteID)
		references dbX.dbo.PSite(SiteID)
		on delete cascade
		on update cascade,
		constraint FK_PSiteRoom_Category foreign key(CategoryID)
		references dbX.dbo.Category(CategoryID)
		on delete cascade
		on update cascade)
go
-----------------------Coupons OK

drop table if exists Coupons
Create table Coupons(
		CouponID int identity(1,1),
		Code nvarchar(50),
		Discount money,            --折扣都用5折(0.5)、6折(0.6)、79折(0.79)
		ExpiryDate datetime,
		Quantity int,
		Available bit default 1,
		constraint UQ_Coupons_Code unique (Code),
		constraint PK_Coupons primary key (CouponID asc))
go
-----------------------COrders

drop table if exists COrders
create table COrders(
		OrderID int identity(1,1),
		CustomerID int,
		ProductID int,
		OrderDate datetime default sysdatetime() not null,     --預設目前的系統時間
		ReturnDate datetime,                                     --預定歸還日期(行動電源除外)
		CancelDate datetime,
		TakeDate datetime,
		EndDate datetime,
		constraint PK_COrders primary key(OrderID),
		constraint FK_COrders_Customers foreign key(CustomerID)
		references dbX.dbo.Customers(CustomerID)
		on delete cascade
		on update cascade,
		constraint FK_COrders_Products foreign key(ProductID)
		references dbX.dbo.Products(ProductID)
		on delete cascade
		on update cascade);
go
-----------------------COrderDetail

drop table if exists COrderDetail
Create table COrderDetail(
		OrderID int identity(1,1),
		CouponID int,
		RoomID int,
		Price money,
		constraint PK_COrderDetail primary key (OrderID asc),
		constraint FK_COrderDetail_PSiteRoom foreign key(RoomID)
		references dbX.dbo.PSiteRoom(RoomID)
		on delete cascade
		on update cascade,
		constraint FK_COrderDetail_Coupons foreign key(CouponID)
		references dbX.dbo.Coupons(CouponID)
		on delete cascade
		on update cascade)
go
-----------------------Advertise OK

drop table if exists Advertise
create table Advertise(
		AdvertiseID int identity(1,1),
		Name nvarchar(50) not null,
		DatePrice money,
		constraint PK_Advertise primary key(AdvertiseID)
		);
go
-----------------------AOrders OK

drop table if exists AOrders
create table AOrders(
		AOrderID int identity(1,1),
		SupplierID int,
		AdvertiseID int,
		OrderDate datetime default sysdatetime() not null,     --預設目前的系統時間
		EndDate datetime,
		Clicks int,
		Price money,
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
		RoomID int,
		Date datetime default sysdatetime(),     --預設目前的系統時間
		Title nvarchar(50),
		Description nvarchar(200),
		Response nvarchar(200),
		Star int,
		constraint PK_Evaluations primary key(EvaluationID),
		constraint FK_Evaluations_Customers foreign key(CustomerID)
		references dbX.dbo.Customers(CustomerID)
		on delete cascade
		on update cascade,
		constraint FK_Evaluations_PSiteRoom foreign key(RoomID)
		references dbX.dbo.PSiteRoom(RoomID)
		on delete cascade
		on update cascade);
go



----------------------------------[Suppliers] 資料表
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (1, N'巴拉巴拉', N'bb@gmail.com', N'09111', N'b123', N'台南市南區', 100, 0)
INSERT [dbo].[Suppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (8, N'明明', N'mm@gmail.com', N'09222', N'm123', N'台南市東區', 100, 0)
INSERT [dbo].[Suppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (9, N'賣西瓜', N'mimi@gmail.com', N'09333', N'mi12', NULL, 100, 0)
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO