create database movie_booking;
use movie_booking;

/* Table 1 - Customer Login - crearea unei tabele in care sa apara informatiile de logare a clientilor*/

create table customer_login (
  customer_id int primary key auto_increment,
  customer_password varchar (40) not null,
  customer_name varchar (50) not null,
  customer_gender varchar (10) not null,
  phone_number varchar (10) not null);
  
  /* Inserarea datelor clientilor pentru logare*/

insert into customer_login (customer_id, customer_password, customer_name, customer_gender, phone_number) values
 	(1,'alex123','Alexandru','M',0756453021),
	(2,'maria_223','Maria','F', 0754673621),
	(3,'mihai.m2023','Mihai','M', 0777453621),
	(4,'ana.maria1121','Maria','F', 0756451251),
	(5,'dima_f','Dima','M',0798753621),
	(6,'zian321','Zian', 'M', 0753758621),
	(7,'irinaz123','Irina', 'F', 0756789621);

/* Table 2 - Movies - crearea unei tabele cu filme si informatii despre acestea*/
  
  create table movies (
  movie_id int primary key not null,  movie_title varchar (20) not null,
  movie_genre varchar (20) not null,
  movie_description varchar (100) not null,
  user_id int not null);
  
  /*inserarea filmelor si informatiilor despre acestea*/
  
  insert into movies (movie_id, movie_title, movie_genre, movie_description, user_id) values
		(10, 'The Beekeeper','Actiune', 'O misiunea brutală de răzbunare a unui bărbat', 1),
		(11, 'Inside Out 2','Comedie', 'Noile emotii ale adolescentei Riley', 2),
		(12, 'Inception','Actiune', 'Furtul de informații din subconștientul oamenilor în timp ce aceștia visează', 3),
		(13, 'La Vita e Bella','Drama', 'Puterea imaginatiei de a se impotrivi realitati in timpul celui de-al II-lea Razboi Mondial', 4),
	    (14, 'Oppenheimer','Istoric', 'Povestea lui O. și a rolului sau în dezvoltarea bombei atomice', 5),
	    (15, 'Kabul','Documentar', 'Vremea, istoria, conflicelete din cel mai aspru loc', 6);
        
 alter table customer_login add foreign key(customer_id) references movies(movie_id); 
 
/* Table 3 - Movie Schedule - crearea unei tabele, reprezentand programul filmelor*/

  create table movie_schedule (
  movie_id int primary key not null,
  movie_name varchar (30) not null,
  movie_lenght varchar (10) not null,
  movie_schedule datetime (6) not null,
  movie_genre varchar (15) not null);
  
  insert into movie_schedule ( movie_id, movie_name, movie_lenght,  movie_schedule, movie_genre) values
        (10, 'The Beekeeper','210', '2024-08-21 14:30','Actiune'),
        (11, 'Inside Out 2','120','2024-08-24 12:30','Comedie'),
        (12, 'Inception','160','2024-09-07 16:00','Actiune'),
        (13, 'La Vita e Bella','200','2024-09-10 13:00','Drama'),
        (14, 'Oppenheimer','200','2024-09-21 18:30','Istoric'),
        (15, 'Kabul','220','2024-10-06 17:30','Documentar');
  
  select*from movie_schedule;
  
  alter table movie_schedule rename movies_schedule; /* redenumirea tabelei*/
  
    /* Table 4 - Payment - crearea unei tabele pentru plata*/

  create table payment (payment_id int primary key not null,
  card_type varchar (10),
  first_name varchar (30),
  last_name varchar (30),
  user_id_user int not null);
  
    /* Table 5 - Customer Transaction - crearea unei tabele, reprezentand tranzactiile cu datele clientilor*/

  create table customer_transaction (
  id_transaction int primary key not null,
  customer_name varchar (40) not null,
  phone_number varchar (10) null,
  selected_movie varchar (30) not null,
  payment_mode varchar (5) not null,
  foreign key(id_transaction) references payment(payment_id));
  
  insert into customer_transaction (id_transaction, customer_name, phone_number, selected_movie,payment_mode) values
          (1, 'Dima', 0798753621, 'The Beekeeper', 'card'),
          (2, 'Maria', 0754673621, 'La Vita e Bella', 'cash'),
          (3, 'Irina', 0756789621, 'Oppenheimer', 'cash'),
          (4, 'Maria', 0756451251, 'Inside Out 2', 'card');

 alter table customer_login add foreign key(customer_id) references customer_transaction(id_transaction);

  desc movies;
  
   alter table movies add foreign key(movie_id) references movie_schedule(movie_id); /*modificarea tabelului "Movies" prin adaugarea unei chei secundare*/
  
  select count(*) from movies; /*numarul tuturor filmelor*/
  
  select*from movies_schedule where movie_lenght=200; /* selectarea filmelor care au durata egala cu 200*/