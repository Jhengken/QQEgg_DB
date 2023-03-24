select * from tProducts
select * from tPSite
select * from tPSiteRoom

select * from tProducts as p
join tPSite as ps on p.ProductID=ps.ProductID
join tPSiteRoom as psr on ps.SiteID =psr.SiteID
where psr.SiteID=2

