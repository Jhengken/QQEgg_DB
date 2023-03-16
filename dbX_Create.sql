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
-----------------------tManagers OK

drop table if exists tManagers
create table tManagers(
		ManagerID int identity(1,1),
		Name nvarchar(50) not null,
		Email nvarchar(50),
		Phone nvarchar(50),
		Password nvarchar(500),
		constraint UQ_tManagers_Email unique (Email),
		constraint UQ_tManagers_Phone unique (Phone),
		constraint PK_tManagers primary key(ManagerID));
go
-----------------------tCustomers OK

drop table if exists tCustomers        
Create table tCustomers(
		CustomerID int identity(1,1),
		Name nvarchar(50) not null,
		Sex bit,
		Email nvarchar(50),
		Phone nvarchar(50),
		Password nvarchar(500),
		Birth datetime,
		CreditCard nvarchar(200),
		CreditPoints int default 100,
		BlackListed bit default 0,
		constraint UQ_tCustomers_Email unique (Email),
		constraint UQ_tCustomers_Phone unique (Phone),
		constraint PK_tCustomers primary key clustered (CustomerID asc))
go
-----------------------tSuppliers OK

drop table if exists tSuppliers
Create table tSuppliers(
		SupplierID int identity(1,1),
		Name nvarchar(50) not null,
		Email nvarchar(50),
		Phone nvarchar(50),
		Password nvarchar(500),
		Address nvarchar(50),
		CreditPoints int default 100,
		BlackListed bit default 0,
		constraint UQ_tSuppliers_Email unique (Email),
		constraint UQ_tSuppliers_Phone unique (Phone),
		constraint PK_tSuppliers primary key(SupplierID),
		);
go
-----------------------tCategory OK

drop table if exists tCategory
Create table tCategory(
		CategoryID int identity(1,1),
		Name nvarchar(50) not null,
		constraint PK_tCategory primary key (CategoryID asc))
go
-----------------------tProducts OK

drop table if exists tProducts
Create table tProducts(
		ProductID int identity(1,1),
		SupplierID int,
		Name nvarchar(50) not null,
		constraint PK_tProducts primary key (ProductID asc),
		constraint FK_tProducts_tSuppliers foreign key(SupplierID)
		references dbX.dbo.tSuppliers(SupplierID)
		--on delete cascade
		--on update cascade
		)
go
-----------------------tPSite

drop table if exists tPSite
Create table tPSite(
		SiteID int identity(1,1),
		ProductID int,
		Name nvarchar(50) not null,
		Image nvarchar(50),
		OpenTime nvarchar(50),
		Latitude nvarchar(50),
		Longitude nvarchar(50),
		Address nvarchar(200),
		Description nvarchar(200),
		constraint PK_tPSite primary key (SiteID asc),
		constraint FK_tPSite_tProducts foreign key(ProductID)
		references dbX.dbo.tProducts(ProductID)
		--on delete cascade
		--on update cascade
		)
go
-----------------------tPSiteRoom

drop table if exists tPSiteRoom
Create table tPSiteRoom(
		RoomID int identity(1,1),
		SiteID int,
		CategoryID int,
		HourPrice money,
		DatePrice money,
		Ping int,
		Image nvarchar(50),
		status bit default 0,
		Description nvarchar(200),
		RoomPassWork nvarchar(200),
		constraint PK_tPSiteRoom primary key (RoomID asc),
		constraint FK_tPSiteRoom_tPSite foreign key(SiteID)
		references dbX.dbo.tPSite(SiteID)
		--on delete cascade
		--on update cascade
		,
		constraint FK_tPSiteRoom_tCategory foreign key(CategoryID)
		references dbX.dbo.tCategory(CategoryID)
		--on delete cascade
		--on update cascade
		)
go
-----------------------tCoupons OK

drop table if exists tCoupons
Create table tCoupons(
		CouponID int identity(1,1),
		Code nvarchar(50),
		Discount money,            --折扣都用5折(0.5)、6折(0.6)、79折(0.79)
		ExpiryDate datetime,
		Quantity int,
		Available bit default 1,
		constraint UQ_tCoupons_Code unique (Code),
		constraint PK_Coupons primary key (CouponID asc))
go
-----------------------tCOrders

drop table if exists tCOrders
create table tCOrders(
		OrderID int identity(1,1),
		CustomerID int,
		ProductID int,
		OrderDate datetime default sysdatetime() not null,     --預設目前的系統時間
		ReturnDate datetime,                                     --預定歸還日期(行動電源除外)
		CancelDate datetime,
		TakeDate datetime,
		EndDate datetime,
		constraint PK_tCOrders primary key(OrderID),
		constraint FK_tCOrders_tCustomers foreign key(CustomerID)
		references dbX.dbo.tCustomers(CustomerID),
		--on delete cascade
		--on update cascade,
		constraint FK_tCOrders_tProducts foreign key(ProductID)
		references dbX.dbo.tProducts(ProductID),
		--on delete cascade
		--on update cascade
		);
go
-----------------------tCOrderDetail

drop table if exists tCOrderDetail
Create table tCOrderDetail(
		OrderID int,
		RoomID int,
		CouponID int,
		Price money,
		constraint PK_tCOrderDetail primary key (OrderID asc,RoomID ASC),
		constraint FK_tCOrderDetail_tCOrders foreign key(OrderID)
		references dbX.dbo.tCOrders(OrderID),
		--on delete cascade,                               --這邊用會出錯，不過Identity不會更改沒差
		--on update cascade,                              --記錄留著不要更改
		constraint FK_tCOrderDetail_tPSiteRoom foreign key(RoomID)
		references dbX.dbo.tPSiteRoom(RoomID),
		--on delete cascade
		--on update cascade,
		constraint FK_tCOrderDetail_tCoupons foreign key(CouponID)
		references dbX.dbo.tCoupons(CouponID),
		--on delete cascade
		--on update cascade
		)
go
-----------------------tAdvertise OK

drop table if exists tAdvertise
create table tAdvertise(
		AdvertiseID int identity(1,1),
		Name nvarchar(50) not null,
		DatePrice money,
		constraint PK_tAdvertise primary key(AdvertiseID)
		);
go
-----------------------tAOrders OK

drop table if exists tAOrders
create table tAOrders(
		AOrderID int identity(1,1),
		SupplierID int,
		AdvertiseID int,
		OrderDate datetime default sysdatetime() not null,     --預設目前的系統時間
		EndDate datetime,
		Clicks int,
		Price money,
		constraint PK_tAOrders primary key(AOrderID),
		constraint FK_tAOrders_tSuppliers foreign key(SupplierID)
		references dbx.dbo.tSuppliers(SupplierID)
		--on delete cascade
		--on update cascade
		,
		constraint FK_tAOrders_tAdvertise foreign key(AdvertiseID)
		references dbx.dbo.tAdvertise(AdvertiseID)
		--on delete cascade
		--on update cascade
		);
go
-----------------------tETitle OK

drop table if exists tETitle
Create table tETitle(
		TitleID int identity(1,1),
		TitleName nvarchar(50) not null,
		constraint PK_tETitle primary key (TitleID asc))
go
-----------------------tEvaluations OK

drop table if exists tEvaluations
create table tEvaluations(
		EvaluationID int identity(1,1),
		CustomerID int,
		RoomID int,
		TitleID int,
		Date datetime default sysdatetime(),     --預設目前的系統時間
		Description nvarchar(200),
		Response nvarchar(200),
		Star int,
		constraint PK_tEvaluations primary key(EvaluationID),
		constraint FK_tEvaluations_tCustomers foreign key(CustomerID)
		references dbX.dbo.tCustomers(CustomerID)
		--on delete cascade
		--on update cascade
		,
		constraint FK_tEvaluations_tPSiteRoom foreign key(RoomID)
		references dbX.dbo.tPSiteRoom(RoomID)
		--on delete cascade
		--on update cascade
		,
		constraint FK_tEvaluations_tETitle foreign key(TitleID)
		references dbX.dbo.tETitle(TitleID)
		--on delete cascade
		--on update cascade
		);
go



----------------------------------[tSuppliers] 資料表
SET IDENTITY_INSERT [dbo].[tSuppliers] ON 

INSERT [dbo].[tSuppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (1, N'巴拉巴拉', N'bb@gmail.com', N'09111', N'b123', N'台南市南區', 100, 0)
INSERT [dbo].[tSuppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (8, N'明明', N'mm@gmail.com', N'09222', N'm123', N'台南市東區', 100, 0)
INSERT [dbo].[tSuppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (9, N'賣西瓜', N'mimi@gmail.com', N'09333', N'mi12', NULL, 100, 0)
SET IDENTITY_INSERT [dbo].[tSuppliers] OFF

----------------------------------[tCategory] 資料表
SET IDENTITY_INSERT [dbo].[tCategory] ON 
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (1, N'多人辦公室')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (2, N'會議室')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (3, N'工作室')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (4, N'展演空間')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (5, N'廚房')
SET IDENTITY_INSERT [dbo].[tCategory] OFF

----------------------------------[tETitle] 資料表
SET IDENTITY_INSERT [dbo].[tETitle] ON 
INSERT [dbo].[tETitle] ([TitleID], [TitleName]) VALUES (1, N'空間環境')
INSERT [dbo].[tETitle] ([TitleID], [TitleName]) VALUES (2, N'設備相關')
SET IDENTITY_INSERT [dbo].[tETitle] OFF

----------------------------------[tProducts] 資料表
SET IDENTITY_INSERT [dbo].[tProducts] ON 
INSERT [dbo].[tProducts] ([ProductID], [SupplierID], [Name]) VALUES (1, 1, N'巴拉巴拉的產品')
INSERT [dbo].[tProducts] ([ProductID], [SupplierID], [Name]) VALUES (2, 8, N'明明的產品')
SET IDENTITY_INSERT [dbo].[tProducts] OFF

----------------------------------[tPSite] 資料表
SET IDENTITY_INSERT [dbo].[tPSite] ON 
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (2, 1, N'巴拉巴拉的第一站點', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (5, 1, N'巴拉巴拉的第二站點', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (6, 2, N'明明的第一站點', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (7, 2, N'明明的第二戰點', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tPSite] OFF

----------------------------------[tPSiteRoom] 資料表
SET IDENTITY_INSERT [dbo].[tPSiteRoom] ON 
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description]) VALUES (1, 2, 1, 10.0000, 100.0000, NULL, NULL, 0, NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description]) VALUES (2, 2, 5, 15.0000, 150.0000, NULL, NULL, 0, NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description]) VALUES (3, 5, 1, 11.0000, 110.0000, NULL, NULL, 0, NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description]) VALUES (4, 5, 5, 12.0000, 120.0000, NULL, NULL, 0, NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description]) VALUES (5, 6, 2, 13.0000, 130.0000, NULL, NULL, 0, NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description]) VALUES (6, 6, 3, 14.0000, 140.0000, NULL, NULL, 0, NULL)
SET IDENTITY_INSERT [dbo].[tPSiteRoom] OFF

----------------------------------[tCustomers] 資料表
SET IDENTITY_INSERT [dbo].[tCustomers] ON 
INSERT [dbo].[tCustomers] ([CustomerID], [Name], [Sex], [Email], [Phone], [Password], [Birth], [CreditCard], [CreditPoints], [BlackListed]) VALUES (1, N'阿奇', 1, N'CHI@gmail.com', N'0977', N'a123', NULL, NULL, 100, 0)
INSERT [dbo].[tCustomers] ([CustomerID], [Name], [Sex], [Email], [Phone], [Password], [Birth], [CreditCard], [CreditPoints], [BlackListed]) VALUES (3, N'宜霖', 0, N'LIN@gmail.com', N'0911', N'a123', NULL, N'1', 100, 0)
SET IDENTITY_INSERT [dbo].[tCustomers] OFF