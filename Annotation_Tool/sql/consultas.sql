-- Mostra todos termos compostos anotados por um anotador
	SELECT DISTINCT 
		a.termocomposto_id, GROUP_CONCAT(t.token SEPARATOR " ") as termocomposto_desc, GROUP_CONCAT(t.id) as tokens_id, (SELECT GROUP_CONCAT(DISTINCT(tag_id)) FROM anotacoes a2 WHERE a2.termocomposto_id = a.termocomposto_id) as tags_id
	FROM 
		anotacoes a 
	INNER JOIN tokens t ON (a.token_id = t.id) 
	WHERE 
		a.anotador_id = 5 AND a.termocomposto_id IS NOT NULL 
	GROUP BY
		a.termocomposto_id, a.tag_id
	ORDER BY
		termocomposto_desc
		
--Atualiza todos textos importados para status REVISADO
UPDATE textos SET aprovador_id = 1, status = "R" WHERE status = "I"

--Mostra textos, quais anotadores anotaram e quantas anotações fizeram (sem contar relacionamentos)
SELECT
	t.id, t.texto, t.`status`, COUNT(a.id) as qtdeanotacoes
FROM
	textos t
INNER JOIN sentencas s ON (t.id = s.texto_id)
INNER JOIN tokens tk ON (s.id = tk.sentenca_id)
INNER JOIN anotacoes a ON (tk.id = a.token_id)
GROUP BY t.id, a.anotador_id

--Mostra anotações iguais de anotadores para um mesmo texto
SELECT 
	a.*, a2.*
FROM 
	anotacoes a
INNER JOIN tokens ON (tokens.id = a.token_id) 
INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) 
INNER JOIN anotacoes a2 ON (a.token_id = a2.token_id AND a.tag_id = a2.tag_id AND a.anotador_id != a2.anotador_id AND a.id != a2.id)
WHERE 
	sentencas.texto_id = 8906 AND a.anotador_id = 5
ORDER BY 
	sentencas.ordem, tokens.ordem, a.tag_id, a.anotador_id
	
--Alocar TODOS textos para anotador_id = 6
INSERT INTO alocacaotexto (projeto_id, texto_id, usuario_id)
SELECT 1, id, 6 FROM textos

--Busca anotações DISCORDANTES de termos simples entre dois anotadores em um texto
SELECT   
	a1.id id1, a1.tag_id tag_id1, t1.tag tag_name1, a1.token_id token_id1, tokens.token token_name1, a1.anotador_id anotador_id1, a1.termocomposto_id termocomposto_id1, a1.status status1, a1.adjudicador adjudicador1, a1.dataanotacao dataanotacao1, a1.abreviatura abreviatura1, a1.umlscui umlscui1, a1.snomedctid snomedctid1, u1.nome anotador_name1
FROM   
	anotacoes a1  
INNER JOIN tokens ON (tokens.id = a1.token_id)   
INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id)   
INNER JOIN tags t1 ON (a1.tag_id = t1.id) 
INNER JOIN usuarios u1 ON (a1.anotador_id = u1.id) 
WHERE   
	sentencas.texto_id = 9054 AND (a1.anotador_id = 5 OR a1.anotador_id = 6) AND a1.termocomposto_id IS NULL AND (a1.id) NOT IN   
	(  
		SELECT   
			a1.id
		FROM   
			anotacoes a1  
		INNER JOIN tokens ON (tokens.id = a1.token_id)   
		INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id)   
		INNER JOIN anotacoes a2 ON (a1.token_id = a2.token_id AND a1.tag_id = a2.tag_id AND a1.anotador_id != a2.anotador_id AND a1.id != a2.id)  
		WHERE   
			sentencas.texto_id = 9054
	)  
ORDER BY   
	sentencas.id, tokens.id, a1.anotador_id
	
--Busca anotações DISCORDANTES de termos COMPOSTOS entre deois anotado4es em um texto
	SELECT   
	a1.id id1, a1.tag_id tag_id1, t1.tag tag_name1, a1.token_id token_id1, tokens.token token_name1, a1.anotador_id anotador_id1, a1.termocomposto_id termocomposto_id1, a1.status status1, a1.adjudicador adjudicador1, a1.dataanotacao dataanotacao1, a1.abreviatura abreviatura1, a1.umlscui umlscui1, a1.snomedctid snomedctid1, u1.nome anotador_name1
FROM   
	anotacoes a1  
INNER JOIN tokens ON (tokens.id = a1.token_id)   
INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id)   
INNER JOIN tags t1 ON (a1.tag_id = t1.id) 
INNER JOIN usuarios u1 ON (a1.anotador_id = u1.id) 
WHERE   
	sentencas.texto_id = 9054 AND (a1.anotador_id = 5 OR a1.anotador_id = 6) AND a1.termocomposto_id IS NOT NULL AND (a1.id) NOT IN   
	(  
		SELECT   
			a1.id
		FROM   
			anotacoes a1  
		INNER JOIN tokens ON (tokens.id = a1.token_id)   
		INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id)   
		INNER JOIN anotacoes a2 ON (a1.token_id = a2.token_id AND a1.tag_id = a2.tag_id AND a1.anotador_id != a2.anotador_id AND a1.id != a2.id AND ( (a1.termocomposto_id IS NULL AND a2.termocomposto_id IS NULL) OR (a1.termocomposto_id IS NOT NULL AND a2.termocomposto_id IS NOT NULL) ) )  
		WHERE   
			sentencas.texto_id = 9054
	)  
ORDER BY   
	sentencas.id, tokens.id, a1.anotador_id
	
/*Anotações SIMPLES do anotador 5 que são CONCORDANTES com o adjudicador para o texto 9054*/
SELECT
	t1.token token1, ta1.tag tag1, a1.*, a2.*
FROM
	anotacoes a1
INNER JOIN tokens t1 ON (t1.id = a1.token_id)
INNER JOIN sentencas s ON (s.id = t1.sentenca_id)
INNER JOIN anotacoes a2 ON
		(
			a2.anotador_id = 5 AND
			a1.token_id = a2.token_id AND 
			a1.tag_id = a2.tag_id AND 
			a1.anotador_id != a2.anotador_id AND 
			a1.id != a2.id AND 
			a1.termocomposto_id IS NULL AND a2.termocomposto_id IS NULL	
		)
INNER JOIN tokens t2 ON (t2.id = a2.token_id)
INNER JOIN tags ta1 ON (ta1.id = a1.tag_id)
INNER JOIN tags ta2 ON (ta2.id = a2.tag_id)
WHERE
	a1.adjudicador = 1 AND s.texto_id = 9054
	
/*Anotações COMPOSTAS do anotador 5 que são CONCORDANTES com o adjudicador para o texto 9054*/
SELECT
	t1.token token1, ta1.tag tag1, a1.*, a2.*
FROM
	anotacoes a1
INNER JOIN tokens t1 ON (t1.id = a1.token_id)
INNER JOIN sentencas s ON (s.id = t1.sentenca_id)
INNER JOIN anotacoes a2 ON
		(
			a2.anotador_id = 5 AND
			a1.token_id = a2.token_id AND 
			a1.tag_id = a2.tag_id AND 
			a1.anotador_id != a2.anotador_id AND 
			a1.id != a2.id AND 
			a1.termocomposto_id IS NOT NULL AND a2.termocomposto_id IS NOT NULL	
		)
INNER JOIN tokens t2 ON (t2.id = a2.token_id)
INNER JOIN tags ta1 ON (ta1.id = a1.tag_id)
INNER JOIN tags ta2 ON (ta2.id = a2.tag_id)
WHERE
	a1.adjudicador = 1 AND s.texto_id = 9054
	
/*Anotações SIMPLES do anotador 5 que são DISCORDANTES com o adjudicador para o texto 9054
Ou seja, anotações do anotador 5 que não foram aceitas*/
SELECT
	t1.token token1, ta1.tag tag1, a1.*
FROM
	anotacoes a1
INNER JOIN tokens t1 ON (t1.id = a1.token_id)
INNER JOIN sentencas s ON (s.id = t1.sentenca_id)
INNER JOIN tags ta1 ON (ta1.id = a1.tag_id)
WHERE
	a1.anotador_id = 5 AND s.texto_id = 9054 AND a1.termocomposto_id IS NULL AND a1.id NOT IN 
	(
	SELECT
		a2.id
	FROM
		anotacoes a1
	INNER JOIN tokens t1 ON (t1.id = a1.token_id)
	INNER JOIN sentencas s ON (s.id = t1.sentenca_id)
	INNER JOIN anotacoes a2 ON
			(
				a2.anotador_id = 5 AND
				a1.token_id = a2.token_id AND 
				a1.tag_id = a2.tag_id AND 
				a1.anotador_id != a2.anotador_id AND 
				a1.id != a2.id AND 
				( 
					(a1.termocomposto_id IS NULL AND a2.termocomposto_id IS NULL)
				) 
			)
	WHERE
		a1.adjudicador = 1 AND s.texto_id = 9054
	)
	
/*Busca tipos semanticos mais utilizados para termos SIMPLES*/
SELECT
	t.tag, COUNT(*) as qtde
FROM
	anotacoes a
INNER JOIN tags t ON (t.id = a.tag_id)
WHERE 
	termocomposto_id IS NULL AND adjudicador = 0 /*AND a.id >= 7000 AND a.id >= 8000*/
GROUP BY
	a.tag_id
ORDER BY
	qtde DESC
	
/*Busca tipos semanticos mais utilizados para termos COMPOSTOS*/
SELECT 
	tag, COUNT(*) as qtde
FROM
	(SELECT
		t.tag, a.*
	FROM
		anotacoes a
	INNER JOIN tags t ON (t.id = a.tag_id)
	WHERE 
		termocomposto_id IS NOT NULL AND adjudicador = 0 /*AND a.id >= 7000 AND a.id >= 8000*/
	GROUP BY
		termocomposto_id
	ORDER BY
		t.tag
	) tab
GROUP BY
	tag
ORDER BY
	qtde DESC