-- when I ran it, just having the 4 drop tables as a baseline, then when I typed "create", copilot was creating all the tables.  
-- all subsequent code was generated from comments
-- for data generation, it can give weird code if "using loops" is not added


drop table if exists dbo.comments
drop table if exists dbo.likes
drop table if exists dbo.posts
drop table if exists dbo.users

create table dbo.users
(
    id int identity(1,1) not null,
    name varchar(50) not null,
    primary key (id)
);

create table dbo.posts
(
    id int identity(1,1) not null,
    title varchar(50) not null,
    content varchar(50) not null,
    user_id int not null,
    primary key (id),
    foreign key (user_id) references dbo.users(id)
);

create table dbo.comments
(
    id int identity(1,1) not null,
    content varchar(50) not null,
    user_id int not null,
    post_id int not null,
    primary key (id),
    foreign key (user_id) references dbo.users(id),
    foreign key (post_id) references dbo.posts(id)
);

create table dbo.likes
(
    id int identity(1,1) not null,
    user_id int not null,
    post_id int not null,
    primary key (id),
    foreign key (user_id) references dbo.users(id),
    foreign key (post_id) references dbo.posts(id)
);

-- insert 100 random data into all existing tables in the database (users, posts, comments and likes) using loops
-- Language: sql
declare @i int = 1
declare @j int = 1
declare @k int = 1
declare @l int = 1

while @i <= 100
begin
    insert into dbo.users
        (name)
    values
        ('user' + cast(@i as varchar(50)))
    set @i = @i + 1
end

while @j <= 100
begin
    insert into dbo.posts
        (title, content, user_id)
    values
        ('title' + cast(@j as varchar(50)), 'content' + cast(@j as varchar(50)), @j)
    set @j = @j + 1
end

while @k <= 100
begin
    insert into dbo.comments
        (content, user_id, post_id)
    values
        ('comment' + cast(@k as varchar(50)), @k, @k)
    set @k = @k + 1
end

while @l <= 100
begin
    insert into dbo.likes
        (user_id, post_id)
    values
        (@l, @l)
    set @l = @l + 1
end;



-- show all posts ordered by likes count
-- Language: sql
select p.id, p.title, p.content, count(l.id) as likes_count
from dbo.posts p
    left join dbo.likes l on p.id = l.post_id
group by p.id, p.title, p.content
order by likes_count desc

-- show all posts order by likes count using ctes
-- Language: sql
with
    cte
    as
    (
        select p.id, p.title, p.content, count(l.id) as likes_count
        from dbo.posts p
            left join dbo.likes l on p.id = l.post_id
        group by p.id, p.title, p.content
    )
select *
from cte
order by likes_count desc

select p.id, p.title, p.content, count(l.id) as likes_count
from dbo.posts p
    left join dbo.likes l on p.id = l.post_id
group by p.id, p.title, p.content
order by likes_count desc


