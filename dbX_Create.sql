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
		HourPrice int,
		DatePrice int,
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
		TradeNo nvarchar(20),
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
		Price int,
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
		DatePrice int,
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
		Price int,
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


----------------------------------[tCategory] ��ƪ�


----------------------------------[tETitle] ��ƪ�


----------------------------------[tProducts] ��ƪ�


----------------------------------[tPSite] ��ƪ�


----------------------------------[tPSiteRoom] ��ƪ�


----------------------------------[tCustomers] ��ƪ�
