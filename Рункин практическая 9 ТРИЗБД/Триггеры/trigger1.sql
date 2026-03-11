create trigger AddClientTrigger
on Clients 
instead of update
as 
begin
declare @id int, @date date
select @id = ID from inserted
select @date = AddDate from inserted
print cast(@id as nvarchar(50)) + ' ========= ' + cast(@date as nvarchar(50))
if (@date < GetDate())
begin
	update Equipment set AddDate = @date where ID = @id
	print 'Запись обновлена'
end
else
begin
	print 'Отмена обновления'
	raiserror('Ошибка обновления',1,1)
end
end