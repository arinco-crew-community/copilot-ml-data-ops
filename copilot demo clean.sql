-- when I ran it, just having the 4 drop tables as a baseline, then when I typed "create", copilot was creating all the tables.  
-- all subsequent code was generated from comments
-- for data generation, it can give weird code if "using loops" is not added


drop table if exists dbo.comments
drop table if exists dbo.likes
drop table if exists dbo.posts
drop table if exists dbo.users


-- show all tables in the database
select * from information_schema.tables
 
-- insert 100 random data into all existing tables in the database (users, posts, comments and likes) using loops

-- show all posts order by likes count 

-- show all posts order by likes count using ctes