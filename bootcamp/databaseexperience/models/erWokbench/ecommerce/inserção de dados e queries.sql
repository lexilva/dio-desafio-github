-- inserção de dados e queries
use ecommerce;
show tables;
--	inserindo Pessoas Físicas
-- SET FOREIGN_KEY_CHECKS=0;
insert into Pf(Cpf)
	value ('23468794527'),
		  ('35789196475'),
          ('98734876347'),
          ('03867715746'),
          ('96845712345'),
          ('42879325675'),
          ('86845712345');
    
-- idClient, idPf, idPj, Fname, Minit, Lname, Padress, Nadress, Numberadress, ComplementAdress, PhoneNumber, email
insert into Clients  (idCPf,Fname,Minit,Lname,Padress,Nadress,Numberadress,phoneNumber,email)
	values	(1,'Alex','T','Mendes','Rua','dos Alpes','11','988722541','mastertest@data.com'),
			(2,'Davi','P','Rochedo','Rodovia','Papaléguas','3500','874663897','fastest@data.com'),
            (3,'Maria Clara','G','Rodrigues','Estrada','Boqueirão do Pequeno','1000','985223648','Oitest@data.com'),
            (4,'Leandro','S','Barroso','Rua','das Flores','19','876998245','therock@data.com'),
            (5,'Adriana','T','Lessa','rua','Jaguapiu','10','988776541','sqltest@data.com'),
			(6,'Fernanda','V','Soares','Rodovia','Fim do Mundo','10000','999666666','longedetudo@dfimdomundo.com'),
			(7,'José','M','de Oliveira','Rua','das Jabuticabas','333','963214578','mfl@dminhavida.com');
            
-- inserindo Pessoas Juridicas
insert into PJ (CNPJ)
	value ('12375891235478');    
insert into Clients  (idCnPj,Fname,Lname,Padress,Nadress,Numberadress,phoneNumber,email)
	values
        (@@identity,'House Tech','Incorporation','Rua','Mahatma Gandhi','111','344776287','faleconosco@housetech.com');
insert into PJ (CNPJ)
	value ('00013648523007');    
insert into Clients  (idCnPj,Fname,Lname,Padress,Nadress,Numberadress,phoneNumber,email)
	values
        (@@identity,'Residencial','ParkIII','Rua','Napoleon Hill','554','777883624','faleconosco@parkiii.com');
insert into Pj(CNPJ)
		value('00016873214987');
insert into Clients (idCNPJ,Fname,Lname,Padress,Nadress,Numberadress,phoneNumber,email)
	values(@@identity,'Planeta','Futebol','Avenida','da Cachoeira Feroz','666','359876674','planetafut@planetafutebol.com.br');
    
    -- inserindo fornecedor

insert into supplier(SocialName,CNPJ, contact)
		values('Os Donos da Bola','635756985241254','965471235');
insert into supplier(SocialName,CNPJ, contact)
		values('Brinquedos S.A.','138726985241254','965471235');
insert into supplier(SocialName,CNPJ, contact)
		values('Fast N Furious','36924985241254','965471235');  
insert into Supplier(SocialName,CNPJ,contact)
		values('World Books','12345678336472','55219587346');
insert into Supplier(SocialName,CNPJ,contact)
		values('Gamelândia','65445678956472','55219587346');
insert into Supplier(SocialName,CNPJ,contact)
		values('Sua Casa','93645678956472','55219587346');
insert into Supplier(SocialName,CNPJ,contact)
		values('Mundo da Mobília','45775678956472','55219587346');
 
select *from supplier;
    -- inserindo estoque
    insert into stock(StoragePlace)
		values('Itaboraí');
    insert into stock(StoragePlace)
		values('Itaipu');
    insert into stock(StoragePlace)
		values('Caxias');
    insert into stock(StoragePlace)
		values('Friburgo');
    insert into stock(StoragePlace)
		values('São Pedro da Aldeia');
        select*from stock;
        
    -- inserindo Produtos
    insert into Product(category,descript,valuation,idPSupplier)
		values('Livros','O Homem mais rico da Babilônia, Ed. Financ.', 20,1);
	insert into Product(category,descript,valuation,idPSupplier)
		values('Livros','Pai Rico Pai Pobre, Ed. Financ', 30,2);
        
	insert into Product(category,descript,valuation,idPSupplier)
		values('Eletrônicos','XBox360', 3399,3);
	insert into Product(category,descript,valuation,idPSupplier)
		values('Eletrônicos','Televisão 40 polegadas', 2500,2);
	insert into Product(category,descript,valuation,idPSupplier)
		values('Eletrônicos','Notebook Gamer ', 4399,2);
        
	insert into Product(category,descript,valuation,idPSupplier)
		values('Brinquedos','Bola de futebol', 79, 3);
	insert into Product(category,descript,valuation,idPSupplier)
		values('Brinquedos','Boneca', 99.99,3);
        
	insert into Product(category,descript,valuation,idPSupplier)
		values('Automotivo','Multimidia com DVD', 3999,4);
	insert into Product(category,descript,valuation,idPSupplier)
		values('Automotivo','Pneu 185 x 65 x aro 15', 589, 4);
        
	insert into Product(category,descript,valuation,dimension,idPSupplier)
		values('Móveis','Mesa de Jantar Retangular', 1199, '120x95x85 cm', 2);
	insert into Product(category,descript,valuation,dimension,idPSupplier)
		values('Móveis','Sofá 3 lug recl.', 1769,'105x300x158', 2);
        
-- produtos em estoque
-- insert into StorageProducts (idStorage,idSProduct,quantity)
	-- values(
-- inserindo vendedor terceiro pj e pf
-- inserindo pedido
-- inserindo pagamento boleto, pix, debito, e crédito
-- inserindo frete
-- inserindo entrega
    
    
    -- SET FOREIGN_KEY_CHECKS=1;
    -- recuperando os clientes pessoa Física
-- Nome Completo dos Clientes PF
	select concat(Fname,' ', minit,' ', Lname) as 'Nome Completo' from clients Group by Fname;
select*from clients;
-- todos registros de clientes
    select *from Clients order by Fname;
-- Registros Completo de Clientes Pessoa Física com CPF
    select concat(Fname,' ',Minit,' ',Lname) As 'Nome Completo',CPF As CPF, concat(Padress,' ',Nadress,', ',Numberadress) As Endereço, phoneNumber,email
		from clients,Pf
		where idCPF = idPF 
		order by Fname;
-- Nome Completo dos Clientes Pj
    select concat(Fname,' ', Lname) as Clientes_PJ from clients where  idCNPJ<>'' ;
-- Registro Completo dos Clientes PJ com CNPJ
	select CNPJ As CNPJ,concat (Fname,' ',Lname) As 'Nome da Empresa',concat(Padress,' ',Nadress,', ',Numberadress) As Endereço, phoneNumber,email
		From clients,PJ
        where idCNPJ = idPJ
        order by CNPJ;
