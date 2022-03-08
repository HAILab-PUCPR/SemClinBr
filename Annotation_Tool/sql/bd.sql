-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.6.24 - MySQL Community Server (GPL)
-- OS do Servidor:               Win32
-- HeidiSQL Versão:              9.2.0.4947
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Copiando estrutura do banco de dados para annotationtool
DROP DATABASE IF EXISTS `annotationtool` ;
CREATE DATABASE IF NOT EXISTS `annotationtool` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `annotationtool`;


-- Copiando estrutura para tabela annotationtool.anotacoes
CREATE TABLE IF NOT EXISTS `anotacoes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` int(10) unsigned NOT NULL,
  `token_id` int(10) unsigned NOT NULL,
  `anotador_id` int(10) unsigned NOT NULL,
  `termocomposto_id` char(36) DEFAULT NULL COMMENT 'Na interface usuário terá de marcar em checkboxes quais tokens fazem parte do termo composto, este código será gerado aleatoriamente (select UUID())',
  `status` char(1) NOT NULL,
  `dataanotacao` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_tag_token_anotador` (`tag_id`,`token_id`,`anotador_id`),
  KEY `FK_token_anotacao` (`token_id`),
  KEY `FK_usuarioanotador_anotacao` (`anotador_id`),
  CONSTRAINT `FK_tag_anotacao` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`),
  CONSTRAINT `FK_token_anotacao` FOREIGN KEY (`token_id`) REFERENCES `tokens` (`id`),
  CONSTRAINT `FK_usuarioanotador_anotacao` FOREIGN KEY (`anotador_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Copiando estrutura para tabela annotationtool.perfis
CREATE TABLE IF NOT EXISTS `perfis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela annotationtool.perfis: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `perfis` DISABLE KEYS */;
INSERT INTO `perfis` (`id`, `nome`) VALUES
	(1, 'Administrador'),
	(2, 'Adjudicador'),
	(3, 'Anotador'),
	(4, 'Revisor de texto');
/*!40000 ALTER TABLE `perfis` ENABLE KEYS */;


-- Copiando estrutura para tabela annotationtool.projetos
CREATE TABLE IF NOT EXISTS `projetos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela annotationtool.projetos: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `projetos` DISABLE KEYS */;
/*!40000 ALTER TABLE `projetos` ENABLE KEYS */;


-- Copiando estrutura para tabela annotationtool.relacionamentos
CREATE TABLE IF NOT EXISTS `relacionamentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `anotacao1_id` int(10) unsigned NOT NULL COMMENT 'Se campo termocomposto_id estiver preenchido a ligação é de termo composto',
  `anotacao2_id` int(10) unsigned NOT NULL COMMENT 'Se campo termocomposto_id estiver preenchido a ligação é de termo composto',
  `anotador_id` int(10) unsigned NOT NULL,
  `dataanotacao` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_anotacao_relacionamento1` (`anotacao1_id`),
  KEY `FK_anotacao_relacionamento2` (`anotacao2_id`),
  KEY `FK_usuarioanotador_relacionamento` (`anotador_id`),
  CONSTRAINT `FK_anotacao_relacionamento1` FOREIGN KEY (`anotacao1_id`) REFERENCES `anotacoes` (`id`),
  CONSTRAINT `FK_anotacao_relacionamento2` FOREIGN KEY (`anotacao2_id`) REFERENCES `anotacoes` (`id`),
  CONSTRAINT `FK_usuarioanotador_relacionamento` FOREIGN KEY (`anotador_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela annotationtool.relacionamentos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `relacionamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `relacionamentos` ENABLE KEYS */;


-- Copiando estrutura para tabela annotationtool.sentencas
CREATE TABLE IF NOT EXISTS `sentencas` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `texto_id` int(11) unsigned NOT NULL,
  `ordem` smallint(5) unsigned NOT NULL,
  `status` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_texto_sentenca` (`texto_id`),
  CONSTRAINT `FK_texto_sentenca` FOREIGN KEY (`texto_id`) REFERENCES `textos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela annotationtool.sentencas: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `sentencas` DISABLE KEYS */;
/*!40000 ALTER TABLE `sentencas` ENABLE KEYS */;


-- Copiando estrutura para tabela annotationtool.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projeto_id` int(10) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_projeto_tag` (`projeto_id`),
  CONSTRAINT `FK_projeto_tag` FOREIGN KEY (`projeto_id`) REFERENCES `projetos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela annotationtool.tags: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;


-- Copiando estrutura para tabela annotationtool.textos
CREATE TABLE IF NOT EXISTS `textos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projeto_id` int(10) unsigned NOT NULL,
  `aprovador_id` int(10) unsigned DEFAULT NULL COMMENT 'Define usuário que aprovou o texto após correções ortográficas',
  `texto` mediumtext NOT NULL,
  `status` char(1) NOT NULL,
  `dataatualizacao` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_projeto_texto` (`projeto_id`),
  KEY `FK_usuarioaprovador_texto` (`aprovador_id`),
  CONSTRAINT `FK_projeto_texto` FOREIGN KEY (`projeto_id`) REFERENCES `projetos` (`id`),
  CONSTRAINT `FK_usuarioaprovador_texto` FOREIGN KEY (`aprovador_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela annotationtool.textos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `textos` DISABLE KEYS */;
/*!40000 ALTER TABLE `textos` ENABLE KEYS */;


-- Copiando estrutura para tabela annotationtool.tokens
CREATE TABLE IF NOT EXISTS `tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sentenca_id` int(10) unsigned NOT NULL,
  `token` varchar(255) NOT NULL,
  `status` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sentenca_token` (`sentenca_id`),
  CONSTRAINT `FK_sentenca_token` FOREIGN KEY (`sentenca_id`) REFERENCES `sentencas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela annotationtool.tokens: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;


-- Copiando estrutura para tabela annotationtool.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `perfil_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_perfil_usuario` (`perfil_id`),
  CONSTRAINT `FK_perfil_usuario` FOREIGN KEY (`perfil_id`) REFERENCES `perfis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela annotationtool.usuarios: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `perfil_id`) VALUES
	(1, 'admin', 'admin@admin.com', 'admin', 1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
