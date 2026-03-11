create trigger AddClientTrigger
on Clients 
instead of insert
as 
begin
declare @series int, @number int, @count int
select @series = PassportSeries from inserted
select @number = PassportNumber from inserted
select @count = count(*) from inserted where PassportSeries = @series and PassportNumber = @number
print cast(@id as nvarchar(50)) + ' ========= ' + cast(@date as nvarchar(50))
if (@count = 0)
begin
	insert into Clients(FullName,PassportSeries,PassportNumber,Address,Phone,Email)
	print 'Запись обновлена'
end
else
begin
	print 'Отмена обновления'
	raiserror('Ошибка обновления',1,1)
end
end