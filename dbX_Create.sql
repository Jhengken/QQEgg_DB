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
		OpenTime nvarchar(50) default '06:00~24:00',
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
		Iframe nvarchar(500),
		status bit default 0,
		Description nvarchar(200),
		RoomPassWord nvarchar(200),
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
		Discount money,            --��J�p���I�Aex 0.5�A�馩����5��(0.5)�B6��(0.6)�B79��(0.79)
		ExpiryDate datetime,
		Quantity int,
		Available bit default 1,
		HowPoint int,
		constraint UQ_tCoupons_Code unique (Code),
		constraint PK_Coupons primary key (CouponID asc))
go
-----------------------tCOrders

drop table if exists tCOrders
create table tCOrders(
		OrderID int identity(1,1),
		TradeNo int,
		CustomerID int,
		ProductID int,
		OrderDate datetime default sysdatetime() not null,     --�w�]�ثe���t�ήɶ�
		CancelDate datetime,
		StartDate datetime,
		EndDate datetime,
		constraint UQ_tCOrders_TradeNo unique (TradeNo),
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
		--on delete cascade,                               --�o��η|�X���A���LIdentity���|���S�t
		--on update cascade,                              --�O���d�ۤ��n���
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
		OrderDate datetime default sysdatetime() not null,     --�w�]�ثe���t�ήɶ�
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
		Date datetime default sysdatetime(),     --�w�]�ثe���t�ήɶ�
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



----------------------------------[tSuppliers] ��ƪ�
SET IDENTITY_INSERT [dbo].[tSuppliers] ON 
INSERT [dbo].[tSuppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (1, N'�کԤک�', N'bb@gmail.com', N'09111', N'b123', N'�x�n���n��', 100, 0)
INSERT [dbo].[tSuppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (8, N'����', N'mm@gmail.com', N'09222', N'm123', N'�x�n���F��', 100, 0)
INSERT [dbo].[tSuppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (9, N'����', N'mimi@gmail.com', N'09333', N'mi12', NULL, 100, 0)
SET IDENTITY_INSERT [dbo].[tSuppliers] OFF

----------------------------------[tCategory] ��ƪ�
SET IDENTITY_INSERT [dbo].[tCategory] ON 
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (1, N'�h�H�줽��')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (2, N'�|ĳ��')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (3, N'�u�@��')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (4, N'�i�t�Ŷ�')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (5, N'�p��')
SET IDENTITY_INSERT [dbo].[tCategory] OFF

----------------------------------[tETitle] ��ƪ�
SET IDENTITY_INSERT [dbo].[tETitle] ON 
INSERT [dbo].[tETitle] ([TitleID], [TitleName]) VALUES (1, N'�Ŷ�����')
INSERT [dbo].[tETitle] ([TitleID], [TitleName]) VALUES (2, N'�]�Ƭ���')
SET IDENTITY_INSERT [dbo].[tETitle] OFF

----------------------------------[tProducts] ��ƪ�
SET IDENTITY_INSERT [dbo].[tProducts] ON 
INSERT [dbo].[tProducts] ([ProductID], [SupplierID], [Name]) VALUES (1, 1, N'�کԤکԪ����~')
INSERT [dbo].[tProducts] ([ProductID], [SupplierID], [Name]) VALUES (2, 8, N'���������~')
INSERT [dbo].[tProducts] ([ProductID], [SupplierID], [Name]) VALUES (3, 9, N'��ʪ����~')
SET IDENTITY_INSERT [dbo].[tProducts] OFF

----------------------------------[tPSite] ��ƪ�
SET IDENTITY_INSERT [dbo].[tPSite] ON 
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (2, 1, N'�کԤکԪ��Ĥ@���I', NULL, N'08:00 ~ 20:00', N'25.0402', N'121.5146', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (5, 1, N'�کԤکԪ��ĤG���I', NULL, N'08:00 ~ 20:00', N'25.0264', N'121.5431', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (6, 2, N'�������Ĥ@���I', NULL, N'08:00 ~ 20:00', N'25.0358', N'121.5675', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (7, 2, N'�������ĤG���I', NULL, N'08:00 ~ 20:00', N'24.1208', N'120.6676', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (8, 3, N'��ʪ��Ĥ@���I', N'1.jpg', N'08:00 ~ 20:00', N'24.1623', N'120.6415', N'�n��', N'��ʯ��I1�y�z')
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (10, 3, N'��ʪ���2���I', N'2.jpg', N'08:00 ~ 20:00', N'22.9923', N'120.2042', N'�_��', N'��ʯ��I2�y�z')
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (11, 3, N'��ʪ���3���I', N'3.jpg', N'08:00~20:00', N'23.0382', N'120.1827', N'�F��', N'��ʯ��I3�y�z')
SET IDENTITY_INSERT [dbo].[tPSite] OFF

----------------------------------[tPSiteRoom] ��ƪ�
SET IDENTITY_INSERT [dbo].[tPSiteRoom] ON 
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (1, 2, 1, 10.0000, 100.0000, 15, N'14.jpg', 0, N'���I8�ж�1�y�z', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (2, 2, 5, 15.0000, 150.0000, 150, N'5.jpg', 0, N'���I8�ж�1�y�z', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (3, 5, 1, 11.0000, 110.0000, 33, N'202303chengbao.jpg', 0, N'���I8�ж�1�y�z', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (4, 5, 5, 12.0000, 120.0000, 25, N'4.jpg', 0, N'���I8�ж�1�y�z', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (5, 6, 2, 13.0000, 130.0000, 20, N'13.jpg', 0, N'���I8�ж�1�y�z', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (6, 6, 3, 14.0000, 140.0000, 15, N'12.jpg', 0, N'���I8�ж�1�y�z', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (7, 8, 2, 14.0000, 140.0000, 10, N'11.jpg', 0, N'���I8�ж�1�y�z', N'123')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (8, 8, 3, 13.0000, 130.0000, 15, N'9.jpg', 0, N'���I8�ж�2�y�z', N'456')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (9, 8, 1, 12.0000, 120.0000, 17, N'8.jpg', 0, N'���I8�ж�3�y�z', N'789')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (10, 10, 5, 12.0000, 130.0000, 16, N'7.jpg', 0, N'���I10�ж�1�y�z', N'111')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (11, 11, 1, 10.0000, 100.0000, 9, N'6.jpg', 0, N'���I11�ж�1�y�z', N'222')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (12, 11, 4, 11.0000, 121.0000, 18, N'10.jpg', 0, N'���I11�ж�2�y�z', N'333')
SET IDENTITY_INSERT [dbo].[tPSiteRoom] OFF

----------------------------------[tCustomers] ��ƪ�
SET IDENTITY_INSERT [dbo].[tCustomers] ON 
INSERT [dbo].[tCustomers] ([CustomerID], [Name], [Sex], [Email], [Phone], [Password], [Birth], [CreditCard], [CreditPoints], [BlackListed]) VALUES (1, N'�٥t', NULL, N'111@gmail.com', N'0911111111', N'$2a$10$1FJqseug2mCQE8h7FdbTIOdBIjq0.hSgBDDupSINPXKpVJCgbshiG', NULL, NULL, 100, 1)
INSERT [dbo].[tCustomers] ([CustomerID], [Name], [Sex], [Email], [Phone], [Password], [Birth], [CreditCard], [CreditPoints], [BlackListed]) VALUES (2, N'���_', NULL, N'222@gmail.com', N'0922222222', N'$2a$10$psmPdpAmXTvN322JsIjY5.tVKjF3SWzN2GxOPp9b5FlT9Z0ZfeLSW', NULL, NULL, 100, 1)
SET IDENTITY_INSERT [dbo].[tCustomers] OFF