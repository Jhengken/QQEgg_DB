use dbX
--�d�ݥثe��trigger
select * from sys.objects where type = 'TR'
select * from sys.sysobjects where xtype = 'TR'

--========tCOrders===================================

------------------�R�����worderID�A�R��tCOrders�~�@�çR��tCOrderDetail
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
	print '�w�R���q��OrderID : ' + str(@OrderID)
end
go

--========tProducts===================================

------------------�R�����wProductID�A�R��Product�~�@�çR��PSite
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

	--delete join�u��R���@��
	delete psr from tProducts as p
	join tPSite as ps on p.ProductID=ps.ProductID
	join tPSiteRoom as psr on ps.SiteID=psr.SiteID
	where p.ProductID=@ProductID

	--print 'tProducts OK' + str(@@NESTLEVEL )
	delete from tPSite where ProductID=@ProductID
	delete from tProducts where ProductID=@ProductID
end

------------------�R�����wSiteID�A�R��PSite�~�@�çR��PSiteRoom
drop trigger if exists tg_tPSite_Delete
go

create trigger tg_tPSite_Delete on tPSite
instead of Delete
as
begin
	print 'tPSite NESTLEVEL' + str(@@NESTLEVEL )
	IF @@NESTLEVEL = 2
		begin
			print 'tPSite NESTLEVEL' + str(@@NESTLEVEL )
			declare @ProductID int
			select @ProductID=ProductID from deleted
			delete from tPSite where ProductID=@ProductID
		end
	else
		begin
			print 'tPSite NESTLEVEL' + str(@@NESTLEVEL )
			declare @SiteID int
			select @SiteID=SiteID from deleted
			delete from tPSiteRoom where SiteID=@SiteID
			delete from tPSite where SiteID=@SiteID
		end
end
			--select * from tPSite where SiteID=@SiteID
			--select * from tPSiteRoom where SiteID=@SiteID

--=================================================



--=========�s�WtOrders�]�s�WtOrderdetail�̭���OrderID==============

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