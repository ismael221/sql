CREATE DATABASE e_pizza;
USE e_pizza;
SHOW TABLES;
CREATE DATABASE IF NOT EXISTS e_pizza;
USE e_pizza;
SHOW TABLES;

CREATE TABLE  `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(10) NOT NULL,
  `senha` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `salario` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`id`));


CREATE TABLE `cardapio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pizza` VARCHAR(45) NOT NULL,
  `ingredientes` VARCHAR(200) NOT NULL,
  `valor` DECIMAL(9,2) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE `entregador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `funcionario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_entregador_funcionario1`
 FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`));

CREATE TABLE `endereco_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cep` VARCHAR(15),
  `rua` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(60) NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `endereco_cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_clientes_endereco_cliente` FOREIGN KEY (`endereco_cliente_id`) REFERENCES `endereco_cliente` (`id`)
  );


CREATE TABLE `feedback` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(300) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE `atendente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `funcionario_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_atendente_funcionario1` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`),
  CONSTRAINT `fk_atendente_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`));


CREATE TABLE `venda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATETIME,
  `valor` DECIMAL(9,2) NOT NULL,
  `entregador_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  `feedback_id` INT NOT NULL,
  `atendente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_venda_entregador1` FOREIGN KEY (`entregador_id`) REFERENCES `entregador` (`id`),
  CONSTRAINT `fk_venda_cliente1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_venda_feedbacks1` FOREIGN KEY (`feedback_id`) REFERENCES `feedback` (`id`),
  CONSTRAINT `fk_venda_atendente1` FOREIGN KEY (`atendente_id`) REFERENCES `atendente` (`id`));

CREATE TABLE `pagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


CREATE TABLE `venda_pagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `venda_id` INT NOT NULL,
  `pagamento_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_venda_has_pagamento_venda1` FOREIGN KEY (`venda_id`) REFERENCES `venda` (`id`),
  CONSTRAINT `fk_venda_has_pagamento_pagamento1` FOREIGN KEY (`pagamento_id`) REFERENCES `pagamento` (`id`));

CREATE TABLE `cardapio_venda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cardapio_id` INT NOT NULL,
  `venda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cardapio_has_venda_cardapio1` FOREIGN KEY (`cardapio_id`) REFERENCES `cardapio` (`id`),
  CONSTRAINT `fk_cardapio_has_venda_venda1` FOREIGN KEY (`venda_id`) REFERENCES `venda` (`id`));

SELECT * FROM funcionario;
INSERT INTO funcionario(nome,cpf,salario) VALUES
('Kamilla Billé Portela Paixão','19838634670',1500),
('Paulo Henrique Cocelo Alentejo Avilla','38579178657',1800),
('Marineuza de Carvalho Bon Farinha','11331787157',1350),
('Laysa Feitosa Saraiva Regufe','20824673336',1212),
('Islayne de Padua Dinis Guimarães','45817086212',1750),
('Geralda Dutra Macedo Guerini','67394467503',2000),
('Theo Louzano Terra Fonseca','49858187475',1890),
('Jacqueline Gayoso Borner Vasgestian','84366418843',1450),
('Elizabeth de Carvalho Barsosa Neves','33263272772',1200),
('Devanir Quintanilha Venancio Pacheco','50024666300',1900);

SELECT * FROM usuario;
INSERT INTO usuario (login,senha) VALUES
('caixa1','12345678'),
('adm','01'),
('caixa2','nunes1');

SELECT * FROM pagamento;
INSERT INTO pagamento(nome) VALUES
('DINHEIRO'),
('CARTÃO DÉBITO'),
('CARTÃO CRÉDITO'),
('PIX'),
('CREDIARIO');

SELECT * FROM cardapio;
INSERT INTO cardapio(pizza,ingredientes,valor) VALUES
('CALABRESA','CALABRESA,TOMATE,MUSSARELA,MOLHO DE TOMATE,AZEITONA,OREGANO',35.90),
('MARGUERITA','TOMATE,MUSSARELA,MOLHO DE TOMATE,AZEITONA,OREGANO',52),
('MODA DA CASA','MUSSARELA,CALABRESA,BACON,TOMATE,FRANGO,PIMENTÃO,MOLHO DE TOMATE,AZEITONA,OREGANO',47.50),
('MUSSARELA','MUSSARELA,MOLHO DE TOMATE,AZEITONA,OREGANO',27.90),
('ROMANA','MUSSARELA,PRESUNTO,CALABRESA,BACON,AZEITONA,OREGANO',35.90),
('BACON E MILHO','MUSSARELA,BACON,MILHO,AZEITONA,OREGANO',47.80);

SELECT * FROM endereco_cliente;
INSERT INTO endereco_cliente(cep,rua,bairro,numero,complemento) VALUES
('03278-090','Rua Luís Pucci','Vila Ema','150',''),
('06060-330','Rua Luiz Leão Harduim','Bela Vista','1690',''),
('13570-180','Avenida Germano Fher Júnior','Jardim Nova São Carlos','1800',''),
('13272-020','Rua Luiz Favrin','Lenheiro','179','antigo 180'),
('13310-292','Rua G','Jardim São José','1478',''),
('13097-220','Rua 8','Residencial Jatibela','444','Antigo 445'),
('09942-050','Rua Presidente Vargas','Canhema','179','Perto do posto ipiranga'),
('04255-160','Travessa Samuel Diez','Núcleo Residencial Princesa DOeste','650',''),
('14164-147','Rua Lindolfo Mossin Filho	','Jardim Jamaica','1475','casa amarela'),
('13060-783','Rua Doutor Israel Martins','Parque Residencial Vila União','12',' apt 12 torre 4'),
('12710-260','Rua Doutor Celestino','Vila Canevari','1950',''),
('17533-392','Rua Santina Maria da Silva','Residencial Vida Nova Maracá (Padre Nobrega)','645',''),
('08653-000','Estrada Samuel','Fazenda Aya','195',''),
('04416-050','Rua Antônio Bispo de Souza','Jardim Vilas Boas','752',''),
('13327-892','Rua Antonio Teruo Kubo','Residencial Vila Martins','963','');

SELECT * FROM cliente;
INSERT INTO cliente(nome,cpf,endereco_cliente_id) VALUES
('Kelly Paixão Texeira','055.878.385-60',1),
('Ronald Antunes Folly','174.169.944-46',2),
('Marisa Vidal Livramento','931.054.582-80',3),
('Girlene Barthon Paulino','864.735.811-20',4),
('Vanderlei Lourenço Cunha','176.684.723-47',5),
('Vicente Albuquerque Nascimento','684.326.163-97',6),
('Maria Alice Teodoro Fernandes','728.991.143-10',7),
('Oliver Caruso Goulart','528.773.417-47',8),
('Gislene Andrade Trancoso','248.855.204-60',9),
('Júlio Spilman Simoes','334.325.511-42',10),
('Berenice Serravalle Vidal','355.133.307-68',11),
('Osvaldo Barroso Fernando','537.258.641-95',12),
('Leandro Folly Barher','216.233.324-43',13),
('Cauê Farias Biango','342.475.767-55',14),
('Sebastião Mello Duarte','954.456.324-58',15);

SELECT * FROM atendente;
SELECT * FROM funcionario;
SELECT * FROM usuario;
INSERT INTO atendente(funcionario_id,usuario_id) VALUES
(1,3),
(2,2),
(3,1);
SELECT * FROM funcionario;
SELECT * FROM entregador;
INSERT INTO entregador(funcionario_id) values
(4),
(5),
(6),
(7),
(8),
(9);
SELECT * FROM feedback;
INSERT INTO feedback(descricao) VALUES
('Sem feedback');
SELECT * FROM venda;
SELECT * FROM entregador;
SELECT * FROM cliente;
SELECT * FROM atendente;
SELECT * FROM cardapio;
INSERT INTO venda(data,valor,entregador_id,cliente_id,feedback_id,atendente_id) VALUES
('2019-10-29 20:44:44','35.90','1','1','1','1'),
('2019-05-22 03:27:22','52','2','2','1','2'),
('2019-03-01 16:57:54','47.50','3','3','1','3'),
('2020-12-12 04:51:10','27.90','4','4','1','1'),
('2019-07-26 15:01:00','35.90','5','5','1','2'),
('2015-04-12 04:46:12','47.80','6','6','1','3'),
('2019-08-18 01:41:02','35.90','1','7','1','1'),
('2020-05-20 19:36:04','52','2','8','1','2'),
('2021-10-18 02:06:59','47.90','3','9','1','3'),
('2021-05-16 19:42:17','27.90','4','10','1','1'),
('2020-12-07 17:09:55','35.90','5','11','1','2'),
('2017-09-01 21:16:12','47.80','6','12','1','3'),
('2022-07-07 20:44:55','35.80','1','13','1','1'),
('2016-07-22 18:59:41','52','2','14','1','2'),
('2020-02-01 05:28:44','47.50','3','15','1','3'),
('2020-01-19 18:02:17','27.90','4','15','1','1'),
('2020-12-16 02:33:42','35.90','5','15','1','2'),
('2018-11-09 10:28:35','47.80','6','14','1','3'),
('2021-03-03 01:54:43','35.90','1','9','1','1');

SELECT * FROM venda_pagamento;
SELECT * FROM venda;
SELECT * FROM pagamento;
INSERT INTO venda_pagamento(venda_id,pagamento_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,1),
(7,2),
(8,3),
(9,4),
(10,5),
(11,1),
(12,2),
(13,3),
(14,4),
(15,5),
(16,1),
(17,2),
(18,3),
(19,4);
SELECT * FROM cardapio_venda;
SELECT * FROM cardapio;
SELECT * FROM venda;
INSERT INTO cardapio_venda(cardapio_id,venda_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(1,7),
(2,8),
(3,9),
(4,10),
(5,11),
(6,12),
(1,13),
(2,14),
(3,15),
(4,16),
(5,17),
(6,18),
(1,19);
