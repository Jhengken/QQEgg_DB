use dbX
--查看目前的trigger
select * from sys.objects where type = 'TR'
select * from sys.sysobjects where xtype = 'TR'

--========tCOrders===================================

------------------刪除指定orderID，刪除tCOrders外一並刪除tCOrderDetail
drop trigger if exists tg_tCOrders_Delete
go

create trigger tg_tCOrders_Delete on tCOrders
instead of Delete
as
begin
	declare @OrderID int
	select @OrderID = OrderID from deleted
	delete from tCOrderDetail where OrderID=@OrderID
	delete from tCOrders where OrderID=@OrderID
	print '已刪除訂單OrderID : ' + str(@OrderID)
end
go

--========tProducts===================================

------------------刪除指定ProductID，刪除Product外一並刪除PSite
drop trigger if exists tg_tProducts_Delete
go

create trigger tg_tProducts_Delete on tProducts
instead of Delete
as
begin
	declare @ProductID int, @SiteID int
	select @ProductID=dp.ProductID, @SiteID=dps.SiteID from deleted as dp
	join tPSite as dps on dp.ProductID=dps.ProductID

	--delete join只能刪除一個
	delete psr from tProducts as p
	join tPSite as ps on p.ProductID=ps.ProductID
	join tPSiteRoom as psr on ps.SiteID=psr.SiteID
	where p.ProductID=@ProductID

	--print 'tProducts OK' + str(@@NESTLEVEL )
	delete from tPSite where ProductID=@ProductID
	delete from tProducts where ProductID=@ProductID
end

------------------刪除指定SiteID，刪除PSite外一並刪除PSiteRoom
drop trigger if exists tg_tPSite_Delete
go

create trigger tg_tPSite_Delete on tPSite
instead of Delete
as
IF @@NESTLEVEL >= 2
	begin
		declare @ProductID int
		select @ProductID=ProductID from deleted
		delete from tPSite where ProductID=@ProductID
		--print 'NESTLEVEL' + str(@@NESTLEVEL )
	end
else
	begin
		declare @SiteID int
		select @SiteID=SiteID from deleted
		delete from tPSiteRoom where SiteID=@SiteID
		delete from tPSite where SiteID=@SiteID
		--print 'PSSSS' + str(@@NESTLEVEL )
		--select * from tPSite where SiteID=@SiteID
		--select * from tPSiteRoom where SiteID=@SiteID
	end

--=================================================



--=========新增tOrders也新增tOrderdetail裡面的OrderID==============

--drop trigger if exists tg_tCOrders_Create
--go

--create trigger tg_tCOrders_Create on tCOrders
--for insert
--as
--begin
--		declare @OrderID nvarchar(20)
--		select @OrderID OrderID from inserted
--		insert
--end

--=================================================