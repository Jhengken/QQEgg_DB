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
	print 'tProducts NESTLEVEL' + str(@@NESTLEVEL )
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
begin
	print 'Object Name: ' + OBJECT_NAME(@@PROCID)  --目前使用哪個物件(tg_tPSite_Delete)
	print 'tPSite NESTLEVEL' + str(@@NESTLEVEL )         --@@PROCID 取出來是 object_id

	IF @@NESTLEVEL = 2
		begin
			print 'Object Name: ' + OBJECT_NAME(@@PROCID)
			print 'tPSite NESTLEVEL' + str(@@NESTLEVEL )

			declare @ProductID int
			select @ProductID=ProductID from deleted
			delete from tPSite where ProductID=@ProductID
		end
	else
		begin
			print 'Object Name: ' + OBJECT_NAME(@@PROCID)
			print 'tPSite NESTLEVEL' + str(@@NESTLEVEL )

			declare @SiteID int
			select @SiteID=SiteID from deleted
			delete from tPSiteRoom where SiteID=@SiteID
			delete from tPSite where SiteID=@SiteID
		end
end

--select * from tPSite where SiteID=@SiteID
--select * from tPSiteRoom where SiteID=@SiteID

--delete tPSite where SiteID = 8
--=================================================