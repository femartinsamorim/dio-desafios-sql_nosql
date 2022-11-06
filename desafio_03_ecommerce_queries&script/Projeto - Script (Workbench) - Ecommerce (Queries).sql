-- Inserção de dados da tabela Cliente
insert into Cliente (Pnome,Mnome,Unome,cpf,endereco) values
('Felipe','F','Amorim',11122233344,'Rua 01, 10 - Bairro 01 - Cidade 01 - Belo Horizonte/MG'),
('Travis','T','Scott',98456547541,'Rua 02, 20 - Bairro 02 - Cidade 02 - Houston/Tx'),
('Maria','M','Marta',87451347541,'Rua 03, 30 - Bairro 03 - Cidade 03 - São Paulo/SP'),
('Surfista','M','da Prainha',98468457541,'Rua 04, 40 - Bairro 03 - Cidade 03 - Rio de Janeiro/RJ')
select * from Cliente;

-- Inserção de dados da tabela Produto
insert into Produto (Pname,classificao_etaria,categoria,avalicao,dimensao) values
('Camiseta Azul',false,'Roupas',4,null),
('Carrinho do Batman',false,'Brinquedos',5,null),
('Whisky',true,'Alimento',5,null),
('TV LCD 52',false,'Eletrônico',5,'52x48')
select * from Produto;