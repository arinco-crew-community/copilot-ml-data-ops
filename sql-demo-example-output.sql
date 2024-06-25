-- Description: This file contains the output of the SQL demo example file

drop table if exists dbo.comments
drop table if exists dbo.likes
drop table if exists dbo.posts
drop table if exists dbo.users

-- create tables with foreign and primary keys
create table dbo.users
(
    id int primary key,
    name varchar(255)
)
create table dbo.posts
(
    id int primary key,
    user_id int,
    title varchar(255),
    content text,
    foreign key (user_id) references dbo.users(id)
)
create table dbo.comments
(
    id int primary key,
    user_id int,
    post_id int,
    content text,
    foreign key (user_id) references dbo.users(id),
    foreign key (post_id) references dbo.posts(id)
)
create table dbo.likes
(
    id int primary key,
    user_id int,
    post_id int,
    foreign key (user_id) references dbo.users(id),
    foreign key (post_id) references dbo.posts(id)
)

-- insert 100 random data into all existing tables in the database (users, posts, comments and likes) using loops
declare @i int = 0
while @i < 100
begin
    insert into dbo.users
    values
        (@i, 'user' + cast(@i as varchar))
    insert into dbo.posts
    values
        (@i, @i, 'post' + cast(@i as varchar), 'content' + cast(@i as varchar))
    insert into dbo.comments
    values
        (@i, @i, @i, 'comment' + cast(@i as varchar))
    insert into dbo.likes
    values
        (@i, @i, @i)
    set @i = @i + 1
end

-- show all posts order by likes count
select p.id, p.title, count(l.id) as likes_count
from dbo.posts p
    left join dbo.likes l on p.id = l.post_id
group by p.id, p.title
order by likes_count desc

-- show all posts order by likes count using ctes
-- language=SQL
with cte as
(
    select p.id, p.title, count(l.id) as likes_count
    from dbo.posts p
        left join dbo.likes l on p.id = l.post_id
    group by p.id, p.title
)
select *
from cte
order by likes_count desc