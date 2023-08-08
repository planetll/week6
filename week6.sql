use regis;
drop trigger if exists update_total_credit;
delimiter //
create trigger update_total_credit
after insert on register_detail for each row
begin
	declare total float;
    select sum(credit) into total from register_detail
    join section using (section_id) 
    join course using (course_id) 
    where register_id = new.register_id;

    update  register set credittotal = total where register_id = new.register_id;
    end//
delimiter ;

show triggers;
insert into register_detail value (3, 1, 1);
select * from register