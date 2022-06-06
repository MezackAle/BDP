create database dbDistribuidoraLTDA;
use dbDistribuidoraLTDA;

/* pedido, produto, fornecedor, nota fiscal, compraprod*/

create table Cliente(
	idCli int primary key,
    CEP bigint(9),
    endereco int,
    foreign key (endereco) references Endereco (endereco),
	NumEndereco char(3),
    CompEnd varchar(50)
);

create table Cliente_PJ(
	CNPJ bigint(14) primary key,
    IE bigint(9),
    idCli int,
    foreign key(idCli) references Cliente (idCli)
);

create table Cliente_PF(
	CPF bigint(11) primary key,
    RG bigint(7),
    DataNasc date,
    RG_Dig char(2),
    idCli int,
    foreign key(idCli) references Cliente (idCli)
);

create table Endereco(
	endereco int primary key,
    IdUF int,
    foreign key (IDUF) references Estado(IDUF),
    idCidade int,
    foreign key (idcidade) references Cidade(Idcidade),
	CEP bigint(9),
    foreign key (CEP) references bairro(CEP)
);

create table Estado(
	UF varchar(2),
    IdUF int primary key
);

create table Cidade(
	IdCidade int primary key,
    NomeCidade varchar(50)
);
create table bairro(
	NomeBairro varchar(50),
	logradouro varchar(200),
    CEP bigint(9) primary key
);

create table ProdutoVenda(
	ValorItem decimal (6,2),
    Qtd int not null,
	codBarras bigint(14),
    foreign key (codBarras) references Produto (codBarras),
    idVenda int,
    foreign key (idVenda) references Venda(idVenda)
);

create table Venda(
	idVenda int primary key,
    dataVenda date default current_timestamp(),
    valorTot decimal(6,2),
    idCli int not null,
    foreign key(idCli) references Cliente (idCli),
    idNota int not null,
    foreign key (idNota) references NotaFiscal (idNota)
);

create table NotaFiscal(
	idNota int primary key,
	dataEmissao date not null,
    totalNota decimal(6,2) not null
);

create table Fornecedor(
	idFornec int primary key,
    CNPJ bigint(14) not null,
    nomeFornec varchar(200) not null,
    telefone bigint(11) 
);

create table Produto(
    codBarras bigint(14) primary key,
    nomeProd varchar(200) not null,
    valorProd decimal(6,2) not null,
    Qtd int 
);

create table CompraProduto(
	ValorItem decimal (6,2) not null,
    Qtd int not null,
	codBarras bigint(14) not null,
    foreign key (codBarras) references Produto (codBarras),
    notaFiscal int not null,
    foreign key (notaFiscal) references  Compra (notaFiscal)
);

create table Compra(
    idFornec int not null,
    foreign key (idFornec) references Fornecedor(idFornec),
    notaFiscal int primary key,
    dataCompra date not null,
    valorTotal decimal (6,2) not null,
    quantTotal int not null
);