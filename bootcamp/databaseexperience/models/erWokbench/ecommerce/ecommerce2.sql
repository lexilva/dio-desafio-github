-- criação do banco de dados para o cenário de E-commerce
 drop database ecommerce;
create database ecommerce;
show databases;
use ecommerce;
show tables ;
-- criar tabela PF
create table Pf(
	idPf int auto_increment not null primary key,
	Cpf varchar(11) not null,
    constraint unique_CPF_client unique(CPF)
);
-- criar tabela PJ
create table PJ(
	idPj int auto_increment not null primary key,
    CNPJ varchar(14) not null,
    constraint unique_CNPJ_client unique(CNPJ)
);

-- criar tabela clientes
create table client(
	idClient int auto_increment not null ,
    idCPf int,
    idCnpj int,
    Fname varchar(20),
    Minit varchar(5) ,
    Lname varchar(15),
    Padress enum('Rua','Avenida','Estrada','Rodovia') default 'Rua',
    Nadress varchar(20),
    Numberadress varchar(5),
    ComplementAdress varchar(15),
    PhoneNumber varchar(14),
    email varchar(45),
    primary key(idClient),
    constraint fk_pf_client foreign Key(idCPf) references Pf(idPf) on delete set null on update cascade,
    constraint fk_pj_client foreign Key(idCNPj) references Pj(idPj) on delete set null
		on update cascade
);
-- criar tabela pedido
create table request(
	idRequest int auto_increment not null primary key,
    descript varchar(45) ,
    idClient int not null,
    idDelivery int not null,
	quantidade int not null,
    constraint fK_request_client foreign key(idClient) references client(idClient) on update cascade
);
-- criar tabela entrerga
create table Delivery(
	idDelivery int auto_increment not null primary key,
    deliveryStatus enum('Em Processamento','Enviado','Entregue', 'Cancelado') not null default'Em Processamento',
    zipCode varchar(15) not null,
    deliverDate date
);
-- criar tabela frete
create table Shipping(
	idShipping int auto_increment not null primary key,
    zipCode varchar(20) not null,
    ShippingValue float not null
);
-- criar tabela fornecedor
create table Supplier(
	idSupplier int auto_increment not null primary key,
    SocialName varchar(20) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
);
-- criar tabela produto
create table Product(
	idProduct int auto_increment not null primary key,
    category enum('Livros','Eletrònicos','Brinquedos','Automotivo','Móveis'),
    descript varchar(45),
    valuation float not null,
    dimension varchar(15),
    idPSupplier int not null,
    constraint fk_supplier foreign Key(idPSupplier) references Supplier(idSupplier) on update cascade
);

-- criar tabela produto/pedido
create table productRquest(
	idPproduct int,
    idPRequest int,
    quantity int not null,
    constraint fk_prod_request foreign key(idPRequest) references request(idRequest) on delete set null on Update cascade,
    constraint fk_prod_ProdRequst foreign key(idPproduct) references Product(idProduct)on delete set null on update cascade
);
-- criar tabela estoque
create table Stock(
	idProdStorage int auto_increment not null,
    StoragePlace varchar(20) not null,
    primary key(idProdStorage)
);

-- criar tabela Produtos em estoque
create table StorageProducts(
	idStorage int,
    idSProduct int,
    quantity int not null,
    primary key(idStorage,idSProduct),
    constraint fk_stored foreign key(idStorage) references Stock(idProdStorage),
    constraint fk_SProduct foreign key(idSProduct) references Product(idProduct)
);

-- criar tabela terceiro PF
create table SellerPF(
	idSellerPf int not null auto_increment primary key,
    SellerCPF varchar(12) NOT NULL ,
    constraint unique_PF_seller unique(SellerCPF)
);
-- criar tabela terceiro PJ
create table SellerPJ(

	idSellerPJ int not null auto_increment primary key,
    SellerCNPJ varchar(12) NOT NULL,
    constraint unique_PJ_client unique(SellerCNPJ)
);
-- criar tabela terceiro vendedor
create table Seller(
	idSeller int auto_increment not null primary key,
    SocialName varchar(20) not null,
    AbstName varchar(30),
    SCPF int not null,
    SCNPJ int not null,
    Phone char(11) not null,
    mailto varchar(25) not null,
    constraint fk_seller_PJ_seller foreign key(SCNPJ) references sellerPj(idSellerPJ),
    constraint fk_seller_PF_seller foreign key(SCPF) references sellerPf(idSellerPf)
);

-- criar tabela disponibiliza
create table Provides(
	idPSupplier int not null,
    idProduct int not null,
    quantity int not null,
    primary key(idPSupplier,idProduct),
    constraint fk_Product_supplier foreign key(idPSupplier) references supplier(idSupplier) on update cascade,
    constraint fk_Product_Products foreign key(idProduct) references product(idProduct) on update cascade
);
-- criar tabela produtos por vendedor
create table ProductsSeller(
	idPseller int,
    IdProduct int,
    prodQuantity int default 1,
    primary key(idPseller,IdProduct),
    constraint fk_product_seller foreign key(idPseller) references seller(idSeller) on update cascade,
    constraint fk_product_product_product foreign key(idProduct) references product(idProduct) on update cascade
);
-- criar tabela boleto
create table PaymentSlip(
	idPSlip int auto_increment not null primary key,
    PSlipNumber varchar(20) not null
);
-- criar tabela crédito
create table CreditCard(
	idCredit int auto_increment not null primary key,
    CardNumber varchar(25) not null,
    expirationDate date not null,
    flagCard varchar(5) not null
);
-- criar tabela débito
create table Debit(
	idDebit int auto_increment not null primary key,
    agency varchar(20) not null,
    numberAccount varchar(5) not null,
    bankName varchar(20) not null
);
-- criar tabela pix
create table Pix(
	idPix int auto_increment not null primary key,
    PixKey varchar(20) not null
);

-- criar tabela pagamento
create table Payment(
	idPayment int auto_increment not null primary key,
    PStatus enum('Processando', 'Pago', 'Não autorizado') not null default 'Processando',
    BenefitName varchar(5) not null,
    BenefitAccount varchar(20) not null,
    BenefitAdrees varchar(45) not null,
    idPixKey int,
    idCCard int,
    idPDebit int,
    idPslip int,
    idPShipping int,
    idCRequest int,
    constraint fk_pix_payment foreign key(idPixKey) references pix(idPix),
    constraint fk_card_payment foreign key(idCCard) references CreditCard(idCredit),
    constraint fk_Slip_payment foreign key(idPslip) references PaymentSlip(idPSlip),
    constraint fk_shipping_payment foreign key(idPShipping) references Shipping(idShipping),
    constraint fk_request_client_paymentStatus foreign key(idCRequest) references request(idRequest)
);

show databases;
show tables;
use information_schema;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';
