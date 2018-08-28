use bookshops
go

update Books
set QuantityBooks = ABS(CHECKSUM(Newid())%50)
go

alter trigger SoldBooks
on Sales
for insert 
as
begin
	declare @CountSoldBooks int
	declare @CountBooks int
	select @CountSoldBooks = Quantity from inserted
	update books set QuantityBooks = QuantityBooks - @CountSoldBooks where Books.ID_BOOK =(select ID_BOOK from inserted) 
end
go

insert into Sales values (6, 'Just for Fun', GETDATE(), 320.65, 6, 1)
go