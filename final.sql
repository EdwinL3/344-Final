create database banks_portal;
use banks_portal;

create table accounts
(
	accountId int not null primary key unique auto_increment,
	ownerName varchar(45) not null,
	owner_ssn int not null,
	balance decimal (10,2) default 0.00,
	account_status varchar(45)
);

create table Transactions
(
	transactionId int not null primary key unique auto_increment,
    accountID int not null,
    transactionType varchar(45) not null,
    transactionAmount decimal (10,2) not null
);

insert into accounts (ownerName, owner_ssn, balance, account_status)
values("Maria Jozef", 123456789, 10000.00, "active"),
		("Linda Jones", 987654321, 2600.00, "inactive"),
        ("John McGrail", 222222222, 100.50, "active"), 
        ("Patty Luna", 111111111, 509.75, "inactive");
select * from accounts;

insert into Transactions (accountID, transactionType, transactionAmount)
values(1, "deposit", 659.98), (3, "withdraw", 899.87), (3, "deposit", 350.00);

select * from Transactions;

delimiter //
create procedure accountTransactions( in accID int)
begin
	select *from Transactions
	where accountID= accID;
end;
call accountTransactions();
delimiter;

delimiter //
create procedure deposit(in accountId int, in amount decimal (10,2))
begin
insert into Transactions(accountID, transactionType, transactionAmount)
values( accountID, "deposit", amount);

update accounts set balance = balance + amount where accountId= accountID;
end;

call deposit();

delimiter //
create procedure withdraw(in accountID int, in amount decimal(10,2))
begin
insert into Transactions( accountId, transactionType, transactionAmount)
values(accountID, "withdraw", amount);
update accounts set balance= balance - amount where accountId= accountID;
end;

call withdraw();