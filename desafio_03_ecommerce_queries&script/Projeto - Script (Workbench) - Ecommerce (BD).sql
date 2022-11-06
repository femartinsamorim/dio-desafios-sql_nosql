-- Criação do banco de dados para o cenário de E-Commerce
create database ecommerce;
use ecommerce;

-- Criar a tabela Cliente
CREATE TABLE Cliente(
	idCliente int auto_increment primary key,
    Pnome varchar(10),
    Mnome char(3),
    Unome varchar(20),
    cpf char(11) not null,
    endereco varchar(30),
    constraint unique_cpf_cliente unique (CPF)
);
-- alter table cliente modify column endereco varchar(255); 
-- alter table Cliente auto_increment=1;
-- (se não fazermos isso o SGBD entende que estamos incrementado uma mesma variável, ou seja
-- para todas tabela inserindo apartir de uma mesma sequencia. Como não é isso que queremos
-- essa ação foi necessária para implementar apartir de uma sequencia como um todo)

-- Criar a tabela Produto
CREATE TABLE Produto(
	idProduto int auto_increment primary key,
    Pname varchar(10) not null,
    classificao_etaria bool default false,
    categoria enum('Eletrônico','Roupas','Brinquedos','Alimento','Móveis') not null,
    avalicao float default 0,
    dimensao varchar(10)
);

-- alter table Produto modify column Pname varchar(255); 

-- Criar a tabela Pagamento (Implementar a tabela e criar a conexão com as tabelas necessárias
-- refletir sobre essa modificação no diagrama (esquema relacional)
-- criar constraints relacionadas ao pagamento
CREATE TABLE Pagamento(
	idCliente int,
    idPagamento int,
    tipo_pagamento enum('Boleto','Cartão','Pix'),
    limite_disponivel float,
    primary key (idCliente,idPagamento)
);
    
-- Criar a tabela Pedido
CREATE TABLE Pedido(
	idPedido int auto_increment primary key,
    idCliente_cliente int,
    status_pedido enum('Solicitado','Processamento','Confirmado','Cancelado','Enviado','Entregue') default 'Processamento',
    descricao_pedido varchar(255),
    frete float default 0,
    pagamento_boleto bool default false,
    constraint fk_pedido foreign key (idCliente_cliente) references Cliente(idCliente) 
			-- on update cascade (função da constraint)
);
desc Pedido;
-- Criar a tabela Estoque
CREATE TABLE Estoque(
	idEstoque int auto_increment primary key,
    local_estoque varchar(255),
    quantidade int default 0
);

-- Criar a tabela Fornecedor
CREATE TABLE Fornecedor(
	idFornecedor int auto_increment primary key,
    razao_social varchar(255) not null,
    cnpj char(15) not null,
    contato varchar(18) not null,
    constraint unique_fornecedor unique (cnpj)
);

-- Criar a tabela Vendedor
CREATE TABLE Vendedor(
	idVendedor int auto_increment primary key,
    Pnome varchar(45),
    Socialnome varchar(45),
    local_vendedor varchar(255),
    razao_social varchar(255) not null,
    cnpj char(15) not null,
    cpf char(11) not null,
    contato varchar(11) not null,
    constraint unique_vendedor_cnpj unique (cnpj),
    constraint unique_vendedor_cpf unique (cpf)
);

-- Criar a Produto_Vendedor (FK)
CREATE TABLE Produto_Vendedor(
	idVendedor_pv int,
	idProduto_pv int,
    quantidade_produto int default 1,
    primary key (idVendedor_pv,idProduto_pv),
    constraint fk_p_vendedor foreign key (idVendedor_pv) references Vendedor(idVendedor),
    constraint fk_produto_v foreign key (idProduto_pv) references Produto(idProduto) 
);

-- Criar a Produto_Pedido (FK)
CREATE TABLE Produto_Pedido(
	idProduto_pedido int,
	idPedido_pedido int,
    quantidade_produto_pedido int default 1,
    status_produto_pedido enum('Disponível','Indisponível') default 'Disponível',
    primary key (idProduto_pedido,idPedido_pedido),
    constraint fk_produto_p foreign key (idProduto_pedido) references Produto(idProduto),
    constraint fk_p_pedido foreign key (idPedido_pedido) references Pedido(idPedido) 
);

-- Criar a Produto_Estoque (FK)
CREATE TABLE Produto_Estoque(
	idProduto_estoque int,
	idPedido_estoque int,
    local_produto_estoque varchar(255) not null,
    primary key (idProduto_estoque,idPedido_estoque),
    constraint fk_produto_e foreign key (idProduto_estoque) references Produto(idProduto),
    constraint fk_p_estoque foreign key (idPedido_estoque) references Estoque(idEstoque) 
);

-- Criar a Fornecedor_Produto (FK)
CREATE TABLE Fornecedor_Produto(
	idFornecedor_produto_f int,
	idFornecedor_produto_p int,
    quantidade int not null,
    primary key (idFornecedor_produto_f,idFornecedor_produto_p),
    constraint fk_fornecedor_p foreign key (idFornecedor_produto_f) references Fornecedor(idFornecedor),
    constraint fk_f_produto foreign key (idFornecedor_produto_p) references Produto(idProduto) 
);
show tables;
use information_schema;
select * from referential_constraints where constraint_schema = "ecommerce";