use bookshops
go

declare SoldBooks cursor -- В место Канады я выбрал США, что бы не париться и не добавлять новую страну ну и т.д.
for
	select count(s.ID_BOOK) as 'Quantity books'
	from Sales s, Shops sh
	where
	s.ID_SHOP = sh.ID_SHOP
	and
	sh.ID_COUNTRY = 1
	and
	s.DateOfSale > getdate() - 365
go

open SoldBooks -- В данный момент курсор очищен, задикларируйте его и не забудьте очистить его))
go

fetch from SoldBooks
go

close SoldBooks
go

deallocate SoldBooks 
go

------------------------------------
declare CountAuthorsDiferendThems cursor keyset
for	
	select count(a.ID_AUTHOR) as 'Quantity authors', th.NameTheme
	from Authors a, Themes th, Books b
	where a.ID_AUTHOR = b.ID_AUTHOR
	and
	b.ID_THEME = th.ID_THEME
	group by th.NameTheme
go

open CountAuthorsDiferendThems
go

fetch next from CountAuthorsDiferendThems
while @@FETCH_STATUS = 0
begin
	declare @Quantuty int
	declare @Theme varchar(25)
	fetch next from CountAuthorsDiferendThems
	print concat(@Quantuty, ' авторов пишут жанре ', @Theme)
end

declare @Quantuty2 int, @Theme2 varchar(25)
fetch Absolute 3 from CountAuthorsDiferendThems into @Quantuty2, @Theme2
print concat(@Quantuty2, ' авторов пишут жанре ', @Theme2)
go

declare @Quantuty2 int, @Theme2 varchar(25)
fetch Absolute -5  from CountAuthorsDiferendThems into @Quantuty2, @Theme2
print concat(@Quantuty2, ' авторов пишут жанре ', @Theme2)
go

declare @Quantuty2 int, @Theme2 varchar(25)
fetch last from CountAuthorsDiferendThems into @Quantuty2, @Theme2
print concat(@Quantuty2, ' авторов пишут жанре ', @Theme2)
go

close CountAuthorsDiferendThems
go

deallocate CountAuthorsDiferendThems 
go