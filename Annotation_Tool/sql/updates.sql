#Adiciona coluna de ordem na tabela de tokens
ALTER TABLE `tokens`
	ALTER `token` DROP DEFAULT;
ALTER TABLE `tokens`
	CHANGE COLUMN `token` `token` VARCHAR(255) NOT NULL AFTER `sentenca_id`,
	ADD COLUMN `ordem` SMALLINT(255) UNSIGNED NOT NULL AFTER `token`;

#Cria tabela de acronimos	
CREATE TABLE `acronimos` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`acronimo` VARCHAR(20) NOT NULL DEFAULT '0',
	`expansao` VARCHAR(300) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`)
);

Insert into acronimos(acronimo,expansao) values("AAS","ácido acetil salicílico");
Insert into acronimos(acronimo,expansao) values("ACTP","angioplastia coronária transluminal percutânea");
Insert into acronimos(acronimo,expansao) values("HCPA","Hospital de Clínicas de Porto Alegre");
Insert into acronimos(acronimo,expansao) values("HAS","hipertensão arterial sistêmica");
Insert into acronimos(acronimo,expansao) values("VO","via oral");
Insert into acronimos(acronimo,expansao) values("ICC","insuficiência cardíaca congestiva");
Insert into acronimos(acronimo,expansao) values("FE","fração de ejeção");
Insert into acronimos(acronimo,expansao) values("ECG","eletrocardiograma");
Insert into acronimos(acronimo,expansao) values("VE","ventrículo esquerdo");
Insert into acronimos(acronimo,expansao) values("IAM","infarto agudo do miocárdio");
Insert into acronimos(acronimo,expansao) values("CD","coronária direita");
Insert into acronimos(acronimo,expansao) values("DAE","dimensão do átrio esquerdo");
Insert into acronimos(acronimo,expansao) values("DA","artéria descendente anterior");
Insert into acronimos(acronimo,expansao) values("TC","tomografia computadorizada");
Insert into acronimos(acronimo,expansao) values("CAT","avaliação crítica tópica");
Insert into acronimos(acronimo,expansao) values("mg/d","miligrama/decilitro");
Insert into acronimos(acronimo,expansao) values("CTI","Centro de Terapia Intensiva");
Insert into acronimos(acronimo,expansao) values("DM","diabetes melitus");
Insert into acronimos(acronimo,expansao) values("CRM","cardio-ressonância magnética");
Insert into acronimos(acronimo,expansao) values("AE","átrio esquerdo");
Insert into acronimos(acronimo,expansao) values("RN","recém-nato");
Insert into acronimos(acronimo,expansao) values("STENT","stent");
Insert into acronimos(acronimo,expansao) values("IG","imunoglobulina");
Insert into acronimos(acronimo,expansao) values("IRC","insuficiência renal crônica");
Insert into acronimos(acronimo,expansao) values("TIMI","medida do fluxo coronário e microvascular");
Insert into acronimos(acronimo,expansao) values("APGAR","Apgar");
Insert into acronimos(acronimo,expansao) values("NR","não-reagente");
Insert into acronimos(acronimo,expansao) values("AVC","acidente vascular cerebral");
Insert into acronimos(acronimo,expansao) values("ACD","artéria coronária direita");
Insert into acronimos(acronimo,expansao) values("CX","artéria circunflexa");
Insert into acronimos(acronimo,expansao) values("RX","raio X");
Insert into acronimos(acronimo,expansao) values("DPOC","doença pulmonar obstrutiva crônica");
Insert into acronimos(acronimo,expansao) values("PSAP","pressão sistólica da artéria pulmonar");
Insert into acronimos(acronimo,expansao) values("PCR","parada cárdio-respiratória");
Insert into acronimos(acronimo,expansao) values("ECO","ecocardiograma");
Insert into acronimos(acronimo,expansao) values("VD","ventrículo direito");
Insert into acronimos(acronimo,expansao) values("IC","insuficiência cardíaca");
Insert into acronimos(acronimo,expansao) values("EV","endovenosa");
Insert into acronimos(acronimo,expansao) values("O2","oxigênio");
Insert into acronimos(acronimo,expansao) values("FC","função cardíaca");
Insert into acronimos(acronimo,expansao) values("NPH","protamina neutra Hagedorn");
Insert into acronimos(acronimo,expansao) values("HCTZ","hidroclortiazida");
Insert into acronimos(acronimo,expansao) values("FO","ferida operatória");
Insert into acronimos(acronimo,expansao) values("INR","razão normalizada internacional");
Insert into acronimos(acronimo,expansao) values("BID","duas vezes ao dia");
Insert into acronimos(acronimo,expansao) values("PA","pressão arterial");
Insert into acronimos(acronimo,expansao) values("SCA","síndrome coronariana aguda");
Insert into acronimos(acronimo,expansao) values("VDRL","laboratório de pesquisa de doenças venéreas");
Insert into acronimos(acronimo,expansao) values("ADA","artéria descendente anterior");
Insert into acronimos(acronimo,expansao) values("ACFA","fibrilação atrial crônica");
Insert into acronimos(acronimo,expansao) values("SL","sublingual");
Insert into acronimos(acronimo,expansao) values("CI","cardiopatia isquêmica");
Insert into acronimos(acronimo,expansao) values("MP","marca-passo");
Insert into acronimos(acronimo,expansao) values("ITU","infecção do trato urinário");
Insert into acronimos(acronimo,expansao) values("BCP","broncopneumonia");
Insert into acronimos(acronimo,expansao) values("DM2","diabetes melitus tipo 2");
Insert into acronimos(acronimo,expansao) values("UI","unidades internacionais");
Insert into acronimos(acronimo,expansao) values("ATB","antibiótico");
Insert into acronimos(acronimo,expansao) values("TS","tipo sangüíneo");
Insert into acronimos(acronimo,expansao) values("TID","dilatação isquêmica transitória");
Insert into acronimos(acronimo,expansao) values("FA","fibrilação atrial");
Insert into acronimos(acronimo,expansao) values("TCE","tronco de coronária esquerda");
Insert into acronimos(acronimo,expansao) values("II","2");
Insert into acronimos(acronimo,expansao) values("IM","insuficiência mitral");
Insert into acronimos(acronimo,expansao) values("PS","pronto socorro");
Insert into acronimos(acronimo,expansao) values("HIV","vírus da imunodeficiência humana");
Insert into acronimos(acronimo,expansao) values("mmHg","milímetro de mercúrio");
Insert into acronimos(acronimo,expansao) values("HCV","vírus da hepatite C");
Insert into acronimos(acronimo,expansao) values("AP","ausculta pulmonar");
Insert into acronimos(acronimo,expansao) values("IgG","imunoglobulina G");
Insert into acronimos(acronimo,expansao) values("MIE","membro inferior esquerdo");
Insert into acronimos(acronimo,expansao) values("PP","parto prematuro");
Insert into acronimos(acronimo,expansao) values("TP","trabalho de parto");
Insert into acronimos(acronimo,expansao) values("AC","ausculta cardíaca");
Insert into acronimos(acronimo,expansao) values("HMG","hemograma");
Insert into acronimos(acronimo,expansao) values("ACX","artéria coronariana circunflexa");
Insert into acronimos(acronimo,expansao) values("EQU","exame qualitativo de urina");
Insert into acronimos(acronimo,expansao) values("UTI","Unidade de Terapia Intensiva");
Insert into acronimos(acronimo,expansao) values("IR","insuficiência renal");
Insert into acronimos(acronimo,expansao) values("SV","supraventricular");
Insert into acronimos(acronimo,expansao) values("DP","doença periapical");
Insert into acronimos(acronimo,expansao) values("III","3");
Insert into acronimos(acronimo,expansao) values("IV","4");
Insert into acronimos(acronimo,expansao) values("MID","membro inferior direito");
Insert into acronimos(acronimo,expansao) values("RNM","ressonância nuclear magnética");
Insert into acronimos(acronimo,expansao) values("RN1","recém-nato 1");
Insert into acronimos(acronimo,expansao) values("TSH","hormônio tíreo-estimulante");
Insert into acronimos(acronimo,expansao) values("CDI","cardioversor-desfibrilador implantável");
Insert into acronimos(acronimo,expansao) values("VM","ventilação mecânica");
Insert into acronimos(acronimo,expansao) values("BRE","bloqueio de ramo esquerdo");
Insert into acronimos(acronimo,expansao) values("IGG","imunoglobulina G");
Insert into acronimos(acronimo,expansao) values("EDA","endoscopia digestiva alta");
Insert into acronimos(acronimo,expansao) values("IT","transição interna");
Insert into acronimos(acronimo,expansao) values("BAV","bloqueio atrioventricular");
Insert into acronimos(acronimo,expansao) values("CHAD","concentrado de hemácias adulto");
Insert into acronimos(acronimo,expansao) values("IgM","imunoglobulina M");
Insert into acronimos(acronimo,expansao) values("DD","diâmetro diastólico");
Insert into acronimos(acronimo,expansao) values("DS","diâmetro sistólico");
Insert into acronimos(acronimo,expansao) values("HPS","Hospital de Pronto Socorro");
Insert into acronimos(acronimo,expansao) values("CK","creatinoquinase");
Insert into acronimos(acronimo,expansao) values("MEI","medicina interna");
Insert into acronimos(acronimo,expansao) values("PC","parada cardíaca");
Insert into acronimos(acronimo,expansao) values("MG","miligrama");
Insert into acronimos(acronimo,expansao) values("TOXO","toxoplamose");
Insert into acronimos(acronimo,expansao) values("ADAE","átrio direito átrio esquerdo");
Insert into acronimos(acronimo,expansao) values("IGM","imunoglobulina M");
Insert into acronimos(acronimo,expansao) values("SC","subcutâneo");
Insert into acronimos(acronimo,expansao) values("CA","câncer");
Insert into acronimos(acronimo,expansao) values("AV","átrio ventricular");
Insert into acronimos(acronimo,expansao) values("BAAR","bacilo álcool ácido resistente");
Insert into acronimos(acronimo,expansao) values("BT","bilirrubina total");
Insert into acronimos(acronimo,expansao) values("EGD","esofagogastroduodenoscopia");
Insert into acronimos(acronimo,expansao) values("TV","taquicardias ventriculares");
Insert into acronimos(acronimo,expansao) values("QT","quimioterapia");
Insert into acronimos(acronimo,expansao) values("TEP","tromboembolismo pulmonar");
Insert into acronimos(acronimo,expansao) values("TVP","trombose venosa profunda");
Insert into acronimos(acronimo,expansao) values("TA","artéria transversa");
Insert into acronimos(acronimo,expansao) values("CO","monóxido de carbono");
Insert into acronimos(acronimo,expansao) values("CP","comprimido");
Insert into acronimos(acronimo,expansao) values("EHCPA","serviço de emergências do Hospital de Clínicas de Porto Alegre");
Insert into acronimos(acronimo,expansao) values("EPED","especialidades pediátricas");
Insert into acronimos(acronimo,expansao) values("HBsAg","antígeno de superfície do vírus da hepatite B");
Insert into acronimos(acronimo,expansao) values("BD","morte cerebral");
Insert into acronimos(acronimo,expansao) values("SSST","sem supradesnível do segmento ST");
Insert into acronimos(acronimo,expansao) values("DDVE","diâmetro diastólico do ventrículo esquerdo");
Insert into acronimos(acronimo,expansao) values("DCE","depuração de creatinina endógena");
Insert into acronimos(acronimo,expansao) values("MsIs","membros inferiores");
Insert into acronimos(acronimo,expansao) values("SF","soro fisiológico");
Insert into acronimos(acronimo,expansao) values("VP","vasopressina");
Insert into acronimos(acronimo,expansao) values("CPAP","pressão positiva contínua em vias aéreas");
Insert into acronimos(acronimo,expansao) values("HD","hemodiálise");
Insert into acronimos(acronimo,expansao) values("ITB","índice tornozelo/braço");
Insert into acronimos(acronimo,expansao) values("IRA","insuficiência renal aguda");
Insert into acronimos(acronimo,expansao) values("TTO","tratamento");
Insert into acronimos(acronimo,expansao) values("DSVE","diâmetro sistólico do ventrículo esquerdo");
Insert into acronimos(acronimo,expansao) values("IECA","inibidor da enzima conversora de angiotensina");
Insert into acronimos(acronimo,expansao) values("VEF1","volume expiratório forçado 1");
Insert into acronimos(acronimo,expansao) values("BAVT","bloqueio atrioventricular total");
Insert into acronimos(acronimo,expansao) values("CF","colo femoral");
Insert into acronimos(acronimo,expansao) values("DVO","distúrbio ventilatório obstrutivo");
Insert into acronimos(acronimo,expansao) values("RTU","ressecção transuretral");
Insert into acronimos(acronimo,expansao) values("EAP","edema agudo de pulmão");
Insert into acronimos(acronimo,expansao) values("ICT","índice cardiotorácico");
Insert into acronimos(acronimo,expansao) values("MSE","membro superior esquerdo");
Insert into acronimos(acronimo,expansao) values("ACx","artéria circunflexa A");
Insert into acronimos(acronimo,expansao) values("AVE","acidente vascular encefálico");
Insert into acronimos(acronimo,expansao) values("HMC","hemocultura");
Insert into acronimos(acronimo,expansao) values("TB","tuberculose");
Insert into acronimos(acronimo,expansao) values("B2","ausculta cardíaca");
Insert into acronimos(acronimo,expansao) values("FR","freqüência respiratória");
Insert into acronimos(acronimo,expansao) values("TE","teste ergométrico");
Insert into acronimos(acronimo,expansao) values("ATC","angioplastia transluminal coronária");
Insert into acronimos(acronimo,expansao) values("IGO","índice do grau de obesidade");
Insert into acronimos(acronimo,expansao) values("NPT","nutrição parenteral total");
Insert into acronimos(acronimo,expansao) values("CD4","grupo de diferenciação 4");
Insert into acronimos(acronimo,expansao) values("CMV","citomegalovírus");
Insert into acronimos(acronimo,expansao) values("EEG","eletroencefalograma");
Insert into acronimos(acronimo,expansao) values("FV","fibrilação ventricular");
Insert into acronimos(acronimo,expansao) values("RV","remodelamento ventricular");
Insert into acronimos(acronimo,expansao) values("VI","6");
Insert into acronimos(acronimo,expansao) values("AJ","antes do jantar");
Insert into acronimos(acronimo,expansao) values("HbsAg","antígeno de superfície da hepatite B");
Insert into acronimos(acronimo,expansao) values("PL","punção lombar");
Insert into acronimos(acronimo,expansao) values("PSA","antígeno específico da próstata");
Insert into acronimos(acronimo,expansao) values("RHZ","rifampicina, isoniazida e pirazinamida");
Insert into acronimos(acronimo,expansao) values("TT","transtorácico");
Insert into acronimos(acronimo,expansao) values("CK-MB","fração MB da creatinofosfoquinase");
Insert into acronimos(acronimo,expansao) values("MSD","membro superior direito");
Insert into acronimos(acronimo,expansao) values("T4","tiroxina");
Insert into acronimos(acronimo,expansao) values("UTIP","Unidade de Terapia Intensiva Pediátrica");
Insert into acronimos(acronimo,expansao) values("AA","após almoço");
Insert into acronimos(acronimo,expansao) values("ACO","anticoagulante oral");
Insert into acronimos(acronimo,expansao) values("LDH","desidrogenase láctica");
Insert into acronimos(acronimo,expansao) values("MM","mieloma múltiplo");
Insert into acronimos(acronimo,expansao) values("NPO","nada por via oral");
Insert into acronimos(acronimo,expansao) values("TGO","transaminase glutâmica oxalacética");
Insert into acronimos(acronimo,expansao) values("ECGs","eletrocardiogramas");
Insert into acronimos(acronimo,expansao) values("HVE","hipertrofia ventricular esquerda");
Insert into acronimos(acronimo,expansao) values("METS","equivalente metabólico");
Insert into acronimos(acronimo,expansao) values("PBF","perfil biofísico fetal");
Insert into acronimos(acronimo,expansao) values("SNE","sonda nasoenteral");
Insert into acronimos(acronimo,expansao) values("CVF","capacidade vital forçada");
Insert into acronimos(acronimo,expansao) values("DDD","DDD");
Insert into acronimos(acronimo,expansao) values("HGT","hemoglicoteste");
Insert into acronimos(acronimo,expansao) values("ILA","índice de líquido amniótico");
Insert into acronimos(acronimo,expansao) values("OK","ok");
Insert into acronimos(acronimo,expansao) values("SVD","sobrecarga ventricular direita");
Insert into acronimos(acronimo,expansao) values("AIT","ataque isquêmico transitório");
Insert into acronimos(acronimo,expansao) values("HGTs","hemoglicotestes");
Insert into acronimos(acronimo,expansao) values("MMII","membros inferiores");
Insert into acronimos(acronimo,expansao) values("MgCx","ramo marginal da artéria circunflexa");
Insert into acronimos(acronimo,expansao) values("PAM","pressão arterial média");
Insert into acronimos(acronimo,expansao) values("PO","pós-operatório");
Insert into acronimos(acronimo,expansao) values("TET","tubo endotraqueal");
Insert into acronimos(acronimo,expansao) values("HAP","hipertensão arterial pulmonar");
Insert into acronimos(acronimo,expansao) values("MTX","metotrexato");
Insert into acronimos(acronimo,expansao) values("PMT","prematuro");
Insert into acronimos(acronimo,expansao) values("PPL","pressão pleural");
Insert into acronimos(acronimo,expansao) values("PUC","Pontifícia Universidade Católica");
Insert into acronimos(acronimo,expansao) values("RDT","radioterapia");
Insert into acronimos(acronimo,expansao) values("SIDA","síndrome da imunodeficiência adquirida");
Insert into acronimos(acronimo,expansao) values("SN","sistema nervoso");
Insert into acronimos(acronimo,expansao) values("VSG","velocidade de sedimentação globular");
Insert into acronimos(acronimo,expansao) values("VSR","vírus sincicial respiratório");
Insert into acronimos(acronimo,expansao) values("BR","bloqueio de ramo");
Insert into acronimos(acronimo,expansao) values("CE","coronária esquerda");
Insert into acronimos(acronimo,expansao) values("DN","data do nascimento");
Insert into acronimos(acronimo,expansao) values("ECA","enzima conversora de angotensina");
Insert into acronimos(acronimo,expansao) values("EEF","escala de expressões faciais");
Insert into acronimos(acronimo,expansao) values("FNB","fenobarbital");
Insert into acronimos(acronimo,expansao) values("NS","não significativo");
Insert into acronimos(acronimo,expansao) values("NTG","nitroglicerina");
Insert into acronimos(acronimo,expansao) values("PROX","próximo");
Insert into acronimos(acronimo,expansao) values("SST","supradesnível do segmento ST");
Insert into acronimos(acronimo,expansao) values("TGP","transaminase glutâmico-pirúvica");
Insert into acronimos(acronimo,expansao) values("TIG","imunoglobulina antitetânica humana");
Insert into acronimos(acronimo,expansao) values("AINE","antiinflamatório não-esteroidal");
Insert into acronimos(acronimo,expansao) values("CN","catéter nasal");
Insert into acronimos(acronimo,expansao) values("CPRE","colangiopancreatografia retrógrada endoscópica");
Insert into acronimos(acronimo,expansao) values("HDA","hemorragia digestiva alta");
Insert into acronimos(acronimo,expansao) values("LCR","licor");
Insert into acronimos(acronimo,expansao) values("Mg-Cx","ramo marginal da artéria circunflexa");
Insert into acronimos(acronimo,expansao) values("PBE","peritonite bacteriana espontânea");
Insert into acronimos(acronimo,expansao) values("PN","pneumonia");
Insert into acronimos(acronimo,expansao) values("BCF","batimentos cardíacos fetais");
Insert into acronimos(acronimo,expansao) values("CV","carga viral");
Insert into acronimos(acronimo,expansao) values("HB","hemoglobina");
Insert into acronimos(acronimo,expansao) values("IAo","insuficiência aórtica");
Insert into acronimos(acronimo,expansao) values("LSD","lobo superior direito");
Insert into acronimos(acronimo,expansao) values("RxTx","raio X de tórax");
Insert into acronimos(acronimo,expansao) values("SAMU","Serviço de Atendimento Médico de Urgência");
Insert into acronimos(acronimo,expansao) values("x/dia","vezes ao dia");
Insert into acronimos(acronimo,expansao) values("AD","átrio direito");
Insert into acronimos(acronimo,expansao) values("ARV","anti-retro viral");
Insert into acronimos(acronimo,expansao) values("AVCs","acidentes vasculares cerebrais");
Insert into acronimos(acronimo,expansao) values("CCA","cardiopatias congênitas em adultos");
Insert into acronimos(acronimo,expansao) values("CEA","antígeno carcinoembrionário");
Insert into acronimos(acronimo,expansao) values("CIV","comunicação interventricular");
Insert into acronimos(acronimo,expansao) values("DRGE","doença do refluxo gastresofágico");
Insert into acronimos(acronimo,expansao) values("GGT","gama GT");
Insert into acronimos(acronimo,expansao) values("HBSAG","antígeno de superfície para hepatite B");
Insert into acronimos(acronimo,expansao) values("HF","história familiar");
Insert into acronimos(acronimo,expansao) values("I-ECA","inibidor da enzima conversora de angiotensina");
Insert into acronimos(acronimo,expansao) values("IAMs","infarto agudo do miocárdio");
Insert into acronimos(acronimo,expansao) values("IVC","insuficiência venosa crônica");
Insert into acronimos(acronimo,expansao) values("MgCX","ramo moarginal da artéria circunflexa");
Insert into acronimos(acronimo,expansao) values("SNG","sonda nasogástrica");
Insert into acronimos(acronimo,expansao) values("TBC","tuberculose");
Insert into acronimos(acronimo,expansao) values("VO2","volume de oxigênio");
Insert into acronimos(acronimo,expansao) values("B12","B12");
Insert into acronimos(acronimo,expansao) values("BRD","bloqueio de ramo direito");
Insert into acronimos(acronimo,expansao) values("EA","emergência ambulatorial");
Insert into acronimos(acronimo,expansao) values("FAN","fator anti-nuclear");
Insert into acronimos(acronimo,expansao) values("FAV","favorável");
Insert into acronimos(acronimo,expansao) values("HNSC","Hospital Nossa Senhora da Conceição");
Insert into acronimos(acronimo,expansao) values("MAP","pressão média de vias aéreas");
Insert into acronimos(acronimo,expansao) values("NEG","negativo");
Insert into acronimos(acronimo,expansao) values("OMA","otite média aguda");
Insert into acronimos(acronimo,expansao) values("QMT","quimioterapia");
Insert into acronimos(acronimo,expansao) values("S-PP","sistólico - parede posterior");
Insert into acronimos(acronimo,expansao) values("TX","tórax");
Insert into acronimos(acronimo,expansao) values("VCI","veia cava inferior");
Insert into acronimos(acronimo,expansao) values("VCM","volume corpuscular médio");
Insert into acronimos(acronimo,expansao) values("C3","complemento 3");
Insert into acronimos(acronimo,expansao) values("CIG","cigarro");
Insert into acronimos(acronimo,expansao) values("CPER","colangiopancreatografia endoscópica retrógrada");
Insert into acronimos(acronimo,expansao) values("DIPI","dipiridamol");
Insert into acronimos(acronimo,expansao) values("EX","ex");
Insert into acronimos(acronimo,expansao) values("HPB","hiperplasia prostática benigna");
Insert into acronimos(acronimo,expansao) values("IVUS","ultra-sonografia intravascular");
Insert into acronimos(acronimo,expansao) values("NBZ","nebulização");
Insert into acronimos(acronimo,expansao) values("PIG","pequeno para idade gestacional");
Insert into acronimos(acronimo,expansao) values("RM","ressonância magnética");
Insert into acronimos(acronimo,expansao) values("TCC","tomografia computadorizada cardiovascular");
Insert into acronimos(acronimo,expansao) values("TSM","tipo sangüíneo da mãe");
Insert into acronimos(acronimo,expansao) values("VLP","videolaparoscopia");
Insert into acronimos(acronimo,expansao) values("AIG","adequado para a idade gestacional");
Insert into acronimos(acronimo,expansao) values("AINES","antiinflamatórios não-esteroidais");
Insert into acronimos(acronimo,expansao) values("CAPS","Centro de Atendimento Psicoprofissionalizante");
Insert into acronimos(acronimo,expansao) values("CEC","circulação extracorpórea");
Insert into acronimos(acronimo,expansao) values("CIPED","Centro de Investigação de Doenças Pediátricas");
Insert into acronimos(acronimo,expansao) values("CT","centro de tratamento");
Insert into acronimos(acronimo,expansao) values("DG","ramo diagonal");
Insert into acronimos(acronimo,expansao) values("Dg","ramo diagonal");
Insert into acronimos(acronimo,expansao) values("DPCD","diálise peritoneal continuada");
Insert into acronimos(acronimo,expansao) values("ESV","extra-sístoles ventriculares");
Insert into acronimos(acronimo,expansao) values("IMi","infarto do miocárdio");
Insert into acronimos(acronimo,expansao) values("IVAS","infecções das vias aéreas superiores");
Insert into acronimos(acronimo,expansao) values("PEG","pré-eclâmpsia grave");
Insert into acronimos(acronimo,expansao) values("R1","residente 1");
Insert into acronimos(acronimo,expansao) values("RG","regime geral");
Insert into acronimos(acronimo,expansao) values("RxT","raio X de tórax");
Insert into acronimos(acronimo,expansao) values("VD-AD","ventrículo direito - átrio direito");
Insert into acronimos(acronimo,expansao) values("VEF","volume expiratório forçado");
Insert into acronimos(acronimo,expansao) values("mL","mililitro");
Insert into acronimos(acronimo,expansao) values("ABD","detecção automática de fronteira");
Insert into acronimos(acronimo,expansao) values("ACTH","hormônio adrenocorticotrófico");
Insert into acronimos(acronimo,expansao) values("AMO","alteração de medula óssea");
Insert into acronimos(acronimo,expansao) values("BB","beta-bloqueador");
Insert into acronimos(acronimo,expansao) values("BI","duas");
Insert into acronimos(acronimo,expansao) values("BIA","balão intra-aórtico");
Insert into acronimos(acronimo,expansao) values("BX","biópsia");
Insert into acronimos(acronimo,expansao) values("C4","complemento 4");
Insert into acronimos(acronimo,expansao) values("CEN","catéter endonasal");
Insert into acronimos(acronimo,expansao) values("CKMB","fração MB da creatinofosfoquinase");
Insert into acronimos(acronimo,expansao) values("DI","dois");
Insert into acronimos(acronimo,expansao) values("DIP","dipiridamol");
Insert into acronimos(acronimo,expansao) values("HP","Helicobacter pylori");
Insert into acronimos(acronimo,expansao) values("LID","lobo inferior direito");
Insert into acronimos(acronimo,expansao) values("MV","murmúrio vesicular");
Insert into acronimos(acronimo,expansao) values("REED","radiograma de esôfago, estômago e duodeno");
Insert into acronimos(acronimo,expansao) values("RNI","razão normalizada internacional");
Insert into acronimos(acronimo,expansao) values("STK","streptoquinase");
Insert into acronimos(acronimo,expansao) values("TPP","trabalho de parto prematuro");
Insert into acronimos(acronimo,expansao) values("VPA","valproato de sódio");
Insert into acronimos(acronimo,expansao) values("mCi","milicurie");
Insert into acronimos(acronimo,expansao) values("mg/dl","miligrama/decilitro");
Insert into acronimos(acronimo,expansao) values("AIH","Autorização de Internação Hospitalar");
Insert into acronimos(acronimo,expansao) values("BEG","bom estado geral");
Insert into acronimos(acronimo,expansao) values("CBZ","carbamazepina");
Insert into acronimos(acronimo,expansao) values("CHILD","Child");
Insert into acronimos(acronimo,expansao) values("CIA","comunicação interatrial");
Insert into acronimos(acronimo,expansao) values("D3","dia 3");
Insert into acronimos(acronimo,expansao) values("DNA","ácido desoxirribonucléico");
Insert into acronimos(acronimo,expansao) values("ENMG","eletroneuromiografia");
Insert into acronimos(acronimo,expansao) values("ESQ","esquerdo");
Insert into acronimos(acronimo,expansao) values("ESSV","extra-sístoles supraventriculares");
Insert into acronimos(acronimo,expansao) values("FBC","freqüência do batimento ciliar");
Insert into acronimos(acronimo,expansao) values("FS","freqüência sinusal");
Insert into acronimos(acronimo,expansao) values("HT","hematócrito");
Insert into acronimos(acronimo,expansao) values("ITUs","infecções do trato urinário");
Insert into acronimos(acronimo,expansao) values("ITr","insuficiência tricúspide");
Insert into acronimos(acronimo,expansao) values("LT","leucograma total");
Insert into acronimos(acronimo,expansao) values("PTU","propiltiouracil");
Insert into acronimos(acronimo,expansao) values("QD","quantidade diária");
Insert into acronimos(acronimo,expansao) values("QN","quando necessário");
Insert into acronimos(acronimo,expansao) values("R2","residente 2");
Insert into acronimos(acronimo,expansao) values("RS","ritmo sinusal");
Insert into acronimos(acronimo,expansao) values("RXT","raio X de tórax");
Insert into acronimos(acronimo,expansao) values("SNC","sistema nervoso central");
Insert into acronimos(acronimo,expansao) values("SO","sala de observação");
Insert into acronimos(acronimo,expansao) values("SVE","sobrecarga ventricular esquerda");
Insert into acronimos(acronimo,expansao) values("VD/AD","ventrículo direito / átrio direito");
Insert into acronimos(acronimo,expansao) values("VPP","ventilação com pressão positiva");
Insert into acronimos(acronimo,expansao) values("s/pp","sistólico / parede posterior");
Insert into acronimos(acronimo,expansao) values("AAA","aneurisma da aorta abdominal");
Insert into acronimos(acronimo,expansao) values("AB","AB");
Insert into acronimos(acronimo,expansao) values("AITs","ataques isquêmicos transitórios");
Insert into acronimos(acronimo,expansao) values("AMBU","ambulatório");
Insert into acronimos(acronimo,expansao) values("BQLT","bronquiolite");
Insert into acronimos(acronimo,expansao) values("CO2","dióxido de carbono");
Insert into acronimos(acronimo,expansao) values("CTC","corticóide");
Insert into acronimos(acronimo,expansao) values("DPN","dispnéia paroxística noturna");
Insert into acronimos(acronimo,expansao) values("DR","doutor");
Insert into acronimos(acronimo,expansao) values("GH","hormônio do crescimento");
Insert into acronimos(acronimo,expansao) values("hdl","lipoproteínas de alta densidade");
Insert into acronimos(acronimo,expansao) values("ICE","insuficiência congestiva esquerda");
Insert into acronimos(acronimo,expansao) values("IFI","imunofluorescência indireta");
Insert into acronimos(acronimo,expansao) values("KG","quilograma");
Insert into acronimos(acronimo,expansao) values("LBA","lavado brônquico alveolar");
Insert into acronimos(acronimo,expansao) values("LDL","lipoproteínas de baixa densidade");
Insert into acronimos(acronimo,expansao) values("M0","medula óssea");
Insert into acronimos(acronimo,expansao) values("PAS","pressão arterial sistêmica");
Insert into acronimos(acronimo,expansao) values("PFH","prova de função hepática");
Insert into acronimos(acronimo,expansao) values("PSP","punção suprapúbica");
Insert into acronimos(acronimo,expansao) values("PT","perímetro");
Insert into acronimos(acronimo,expansao) values("QI","quociente de inteligência");
Insert into acronimos(acronimo,expansao) values("RMN","ressonância magnética");
Insert into acronimos(acronimo,expansao) values("SG","assobrevida global");
Insert into acronimos(acronimo,expansao) values("SVs","sinais vitais");
Insert into acronimos(acronimo,expansao) values("T1","tempo 1");
Insert into acronimos(acronimo,expansao) values("i-ECA","inibidores da enzima conversora de angiotensina");
Insert into acronimos(acronimo,expansao) values("iECA","inibidores da enzima conversora de angiotensina");
Insert into acronimos(acronimo,expansao) values("mcg/d","microgramas/decilitro");
Insert into acronimos(acronimo,expansao) values("ACM","artéria cerebral média");
Insert into acronimos(acronimo,expansao) values("ACTPs","angioplastias coronarianas transluminais percutâneas");
Insert into acronimos(acronimo,expansao) values("AESP","atividade elétrica sem pulso");
Insert into acronimos(acronimo,expansao) values("AIRV","alterações inespecíficas da repolarização ventricular");
Insert into acronimos(acronimo,expansao) values("ANTI","anti");
Insert into acronimos(acronimo,expansao) values("AVCi","acidente vascular cerebral isquêmico");
Insert into acronimos(acronimo,expansao) values("AVEi","acidente vascular encefálico isquêmico");
Insert into acronimos(acronimo,expansao) values("AZT","zidovudina");
Insert into acronimos(acronimo,expansao) values("B6","B6");
Insert into acronimos(acronimo,expansao) values("BQTE","bronquite");
Insert into acronimos(acronimo,expansao) values("CCT","carcinoma de células transicionais");
Insert into acronimos(acronimo,expansao) values("DM1","diabetes melitus tipo I");
Insert into acronimos(acronimo,expansao) values("EBV","Epstein-Barr vírus");
Insert into acronimos(acronimo,expansao) values("EGDA","anastomose esofagogastroduodenal");
Insert into acronimos(acronimo,expansao) values("FAF","arma de fogo");
Insert into acronimos(acronimo,expansao) values("HBV","vírus da hepatite B");
Insert into acronimos(acronimo,expansao) values("HCG","hormônio da gonadotrofina coriônica");
Insert into acronimos(acronimo,expansao) values("HMV","Hospital Moinhos de Vento");
Insert into acronimos(acronimo,expansao) values("HSL","Hospital São Lucas");
Insert into acronimos(acronimo,expansao) values("IMC","índice de massa corporal");
Insert into acronimos(acronimo,expansao) values("LH","hormônio luteinizante");
Insert into acronimos(acronimo,expansao) values("LIE","lobo inferior esquerdo");
Insert into acronimos(acronimo,expansao) values("MAM","artéria mamária");
Insert into acronimos(acronimo,expansao) values("MED","médio");
Insert into acronimos(acronimo,expansao) values("METs","equivalentes metabólicos");
Insert into acronimos(acronimo,expansao) values("MGCX","ramo marginal da artéria circunflexa");
Insert into acronimos(acronimo,expansao) values("OAA","obstrução arterial aguda");
Insert into acronimos(acronimo,expansao) values("P/C","polifenol/carboidrato");
Insert into acronimos(acronimo,expansao) values("PAAF","punção aspirativa por agulha fina");
Insert into acronimos(acronimo,expansao) values("PCRs","paradas cardio-respiratórias");
Insert into acronimos(acronimo,expansao) values("PNA","pielonefrite aguda");
Insert into acronimos(acronimo,expansao) values("R-x","raio X");
Insert into acronimos(acronimo,expansao) values("SIADH","síndrome de secreção inapropriada de hormônio anti-diurético");
Insert into acronimos(acronimo,expansao) values("SK","estreptoquinase");
Insert into acronimos(acronimo,expansao) values("SOP","síndrome do ovário policístico");
Insert into acronimos(acronimo,expansao) values("SUS","Sistema Único de Saúde");
Insert into acronimos(acronimo,expansao) values("TGI","trato gastrointestinal");
Insert into acronimos(acronimo,expansao) values("TMO","transplante de medula óssea");
Insert into acronimos(acronimo,expansao) values("TPO","tireoperoxidase");
Insert into acronimos(acronimo,expansao) values("TVNS","taquicardia ventricular não sustentada");
Insert into acronimos(acronimo,expansao) values("VD>AD","ventrículo direito > átrio direito");
Insert into acronimos(acronimo,expansao) values("cm2","centímetro quadrado");
Insert into acronimos(acronimo,expansao) values("o2","oxigênio");
Insert into acronimos(acronimo,expansao) values("ACV","aparelho cardiovascular");
Insert into acronimos(acronimo,expansao) values("AMPI","ampicilina");
Insert into acronimos(acronimo,expansao) values("BMO","biópsia de medula óssea");
Insert into acronimos(acronimo,expansao) values("CIE","carótida interna esquerda");
Insert into acronimos(acronimo,expansao) values("CM","centímetro");
Insert into acronimos(acronimo,expansao) values("CPAPn","pressão positiva contínua em vias aéreas nasal");
Insert into acronimos(acronimo,expansao) values("CR","creatinina");
Insert into acronimos(acronimo,expansao) values("DMG","diabetes melitus gestacional");
Insert into acronimos(acronimo,expansao) values("DMSA","ácido dimercaptosuccínico");
Insert into acronimos(acronimo,expansao) values("DRA","doutora");
Insert into acronimos(acronimo,expansao) values("DV","densitovolumetria");
Insert into acronimos(acronimo,expansao) values("DVP","derivação ventrículo peritoneal");
Insert into acronimos(acronimo,expansao) values("EMG","emergência");
Insert into acronimos(acronimo,expansao) values("FEVE","fração de ejeção do ventrículo esquerdo");
Insert into acronimos(acronimo,expansao) values("FK","trakolimus");
Insert into acronimos(acronimo,expansao) values("FiO2","fração de oxigênio inspirado");
Insert into acronimos(acronimo,expansao) values("GA","gasometria");
Insert into acronimos(acronimo,expansao) values("HCO3","bicarbonato");
Insert into acronimos(acronimo,expansao) values("HPIV","hemorragia peri-intraventricular");
Insert into acronimos(acronimo,expansao) values("HS","horas");
Insert into acronimos(acronimo,expansao) values("HTLV","vírus T-linfotrópico humano");
Insert into acronimos(acronimo,expansao) values("ISQ","isquêmico");
Insert into acronimos(acronimo,expansao) values("KTTP","tempo de tromboplastina parcialmente ativada");
Insert into acronimos(acronimo,expansao) values("LMA","leucemia mielóide aguda");
Insert into acronimos(acronimo,expansao) values("LOC","lúcido, orientado e consciente");
Insert into acronimos(acronimo,expansao) values("LSE","lobo superior esquerdo");
Insert into acronimos(acronimo,expansao) values("MA","meningites assépticas");
Insert into acronimos(acronimo,expansao) values("MAC","ambulatório de cardiologia");
Insert into acronimos(acronimo,expansao) values("MM-DA","mamária - descendente anterior");
Insert into acronimos(acronimo,expansao) values("MMIIs","membros inferiores");
Insert into acronimos(acronimo,expansao) values("MO","medula óssea");
Insert into acronimos(acronimo,expansao) values("MT","metiltestosterona");
Insert into acronimos(acronimo,expansao) values("MTD","dose máxima tolerada");
Insert into acronimos(acronimo,expansao) values("NEO","neonatal");
Insert into acronimos(acronimo,expansao) values("NEURO","neurologia");
Insert into acronimos(acronimo,expansao) values("NPS","nitroprussiato de sódio");
Insert into acronimos(acronimo,expansao) values("ORL","otorrinolaringologia");
Insert into acronimos(acronimo,expansao) values("PLAQ","plaquetas");
Insert into acronimos(acronimo,expansao) values("PPNL","propranolol");
Insert into acronimos(acronimo,expansao) values("PTH","paratormônio");
Insert into acronimos(acronimo,expansao) values("PVC","pressão venosa central");
Insert into acronimos(acronimo,expansao) values("PaO2","pressão arterial de oxigênio");
Insert into acronimos(acronimo,expansao) values("RA","rêmora atrial");
Insert into acronimos(acronimo,expansao) values("RDW","amplitude de distribuição eritrocitária");
Insert into acronimos(acronimo,expansao) values("RH","rifampicina e isoniazida");
Insert into acronimos(acronimo,expansao) values("RxABD","raio X abdominal");
Insert into acronimos(acronimo,expansao) values("SFA","sofrimento fetal agudo");
Insert into acronimos(acronimo,expansao) values("SM","silagem de milho");
Insert into acronimos(acronimo,expansao) values("SPA","Serviço de Pronto Atendimento");
Insert into acronimos(acronimo,expansao) values("SpO2","saturação percutânea de oxigênio");
Insert into acronimos(acronimo,expansao) values("TAB","transtorno afetivo bipolar");
Insert into acronimos(acronimo,expansao) values("TAP","tempo de atividade de protrombina");
Insert into acronimos(acronimo,expansao) values("TARV","terapia antiretroviral");
Insert into acronimos(acronimo,expansao) values("TG","triglicerídeos");
Insert into acronimos(acronimo,expansao) values("TILT","teste de inclinação ortostática");
Insert into acronimos(acronimo,expansao) values("UCA","cultura de urina");
Insert into acronimos(acronimo,expansao) values("UCI","unidade de cuidados intermediários");
Insert into acronimos(acronimo,expansao) values("URC","urocultura");
Insert into acronimos(acronimo,expansao) values("US","ultra-sonografia");
Insert into acronimos(acronimo,expansao) values("UTIN","Unidade de Terapia Intensiva Neonatal");
Insert into acronimos(acronimo,expansao) values("VD28","ventrículo direito 28");
Insert into acronimos(acronimo,expansao) values("pH","potencial hidrogeniônico");
Insert into acronimos(acronimo,expansao) values("A2","amostra 2");
Insert into acronimos(acronimo,expansao) values("ADC","coeficiente de difusão aparente");
Insert into acronimos(acronimo,expansao) values("AMgCx","ramo marginal da artéria circunflexa");
Insert into acronimos(acronimo,expansao) values("ANCA","anticorpo anticitoplasma de neutrófilo");
Insert into acronimos(acronimo,expansao) values("ARVŽs","antiretrovirais");
Insert into acronimos(acronimo,expansao) values("BFM","Berlin-Frankfurt-Münster");
Insert into acronimos(acronimo,expansao) values("BQLTE","bronquiolite");
Insert into acronimos(acronimo,expansao) values("CAPD","diálise peritoneal ambulatorial crônica");
Insert into acronimos(acronimo,expansao) values("CC","cardiopatias congênitas");
Insert into acronimos(acronimo,expansao) values("CHC","carcinoma hepatocelular");
Insert into acronimos(acronimo,expansao) values("CPT","capacidade pulmonar total");
Insert into acronimos(acronimo,expansao) values("CREAT","creatinina");
Insert into acronimos(acronimo,expansao) values("CTICC","Centro de Tratamento Intensivo Clínico-cirúrgico");
Insert into acronimos(acronimo,expansao) values("DAOP","doença arterial obstrutiva periférica");
Insert into acronimos(acronimo,expansao) values("DBPOC","doença broncopulmonar obstrutiva crônica");
Insert into acronimos(acronimo,expansao) values("DC","doença celíaca");
Insert into acronimos(acronimo,expansao) values("DDI","DDI");
Insert into acronimos(acronimo,expansao) values("DMO","densidade mineral óssea");
Insert into acronimos(acronimo,expansao) values("DRC","doença renal crônica");
Insert into acronimos(acronimo,expansao) values("DX","diagnóstico");
Insert into acronimos(acronimo,expansao) values("EF","exame físico");
Insert into acronimos(acronimo,expansao) values("EFZ","efavirenz");
Insert into acronimos(acronimo,expansao) values("ELLA","endoprótese arterial de perna esquerda");
Insert into acronimos(acronimo,expansao) values("EPF","exame parasitológico de fezes");
Insert into acronimos(acronimo,expansao) values("EPO","eritropoetina");
Insert into acronimos(acronimo,expansao) values("EQ","esquema quimioterápico");
Insert into acronimos(acronimo,expansao) values("ESBL","produtoras de beta-lactamase com espectro estendido");
Insert into acronimos(acronimo,expansao) values("FOP","forame oval patente");
Insert into acronimos(acronimo,expansao) values("FSH","hormônio folículo estimulante");
Insert into acronimos(acronimo,expansao) values("G3","gestação 3");
Insert into acronimos(acronimo,expansao) values("HELLP","anemia hemolítica, níveis elevados de enzimas hepáticas e contagem baixa de plaquetas");
Insert into acronimos(acronimo,expansao) values("HMP","história médica pregressa");
Insert into acronimos(acronimo,expansao) values("IAO","insuficiência aórtica");
Insert into acronimos(acronimo,expansao) values("ICP","intervenção coronária percutânea");
Insert into acronimos(acronimo,expansao) values("IGP","idade gestacional no parto");
Insert into acronimos(acronimo,expansao) values("IN","intranasais");
Insert into acronimos(acronimo,expansao) values("JUP","junção uretero-piélica");
Insert into acronimos(acronimo,expansao) values("L1","lombar 1");
Insert into acronimos(acronimo,expansao) values("LM","lobo médio");
Insert into acronimos(acronimo,expansao) values("LV","leite de vaca");
Insert into acronimos(acronimo,expansao) values("MI","membro inferior");
Insert into acronimos(acronimo,expansao) values("MIBI","metoxi-isobutil-isonitrila");
Insert into acronimos(acronimo,expansao) values("MIŽs","membros inferiores");
Insert into acronimos(acronimo,expansao) values("MRSA","Staphylococcus aureus resistente à meticilina");
Insert into acronimos(acronimo,expansao) values("MTZ","mirtazapina");
Insert into acronimos(acronimo,expansao) values("MsIS","membros inferiores");
Insert into acronimos(acronimo,expansao) values("NC","nervo craniano");
Insert into acronimos(acronimo,expansao) values("OBS","observação");
Insert into acronimos(acronimo,expansao) values("OD","olho direito");
Insert into acronimos(acronimo,expansao) values("OE","olho esquerdo");
Insert into acronimos(acronimo,expansao) values("PCO2","pressão de dióxido de carbono");
Insert into acronimos(acronimo,expansao) values("PCP","pressão capilar pulmonar");
Insert into acronimos(acronimo,expansao) values("PCT","paciente");
Insert into acronimos(acronimo,expansao) values("PMAP","pressão média da artéria pulmonar");
Insert into acronimos(acronimo,expansao) values("PNE","portador de necessidades especiais");
Insert into acronimos(acronimo,expansao) values("PNTx","pneumotórax");
Insert into acronimos(acronimo,expansao) values("POA","Porto Alegre");
Insert into acronimos(acronimo,expansao) values("PPD","derivado protéico purificado");
Insert into acronimos(acronimo,expansao) values("PV","parto vaginal");
Insert into acronimos(acronimo,expansao) values("QID","quadrante inferior direito");
Insert into acronimos(acronimo,expansao) values("R-X","raio X");
Insert into acronimos(acronimo,expansao) values("RBV","ribavirina");
Insert into acronimos(acronimo,expansao) values("RC","risco cardiovascular");
Insert into acronimos(acronimo,expansao) values("RCP","reanimação cardiopulmonar");
Insert into acronimos(acronimo,expansao) values("RD","retinopatia diabética");
Insert into acronimos(acronimo,expansao) values("REAG","reagente");
Insert into acronimos(acronimo,expansao) values("RGE","refluxo gastresofágico");
Insert into acronimos(acronimo,expansao) values("RHA","ruídos hidroaéreos");
Insert into acronimos(acronimo,expansao) values("RN2","recém-nato 2");
Insert into acronimos(acronimo,expansao) values("RPD","retinopatia diabética proliferativa");
Insert into acronimos(acronimo,expansao) values("RXTX","raio X de tórax");
Insert into acronimos(acronimo,expansao) values("S/N","se necessário");
Insert into acronimos(acronimo,expansao) values("SMC","serviço médico de cirurgia");
Insert into acronimos(acronimo,expansao) values("SMO","serviço médico de oncologia");
Insert into acronimos(acronimo,expansao) values("SR","senhor");
Insert into acronimos(acronimo,expansao) values("SVA","sonda uretral plástica");
Insert into acronimos(acronimo,expansao) values("TCEC","tempo de circulação extracorpórea");
Insert into acronimos(acronimo,expansao) values("TIFF","Tiffeneau");
Insert into acronimos(acronimo,expansao) values("TOT","tubo orotraqueal");
Insert into acronimos(acronimo,expansao) values("TSRN","tipo sangüíneo do recém-nato");
Insert into acronimos(acronimo,expansao) values("UBS","Unidade Básica de Saúde");
Insert into acronimos(acronimo,expansao) values("VA","vias aéreas");
Insert into acronimos(acronimo,expansao) values("VAD","vincristina, adriblastina e dexametasona");
Insert into acronimos(acronimo,expansao) values("VB","vesícula biliar");
Insert into acronimos(acronimo,expansao) values("VCR","vincristina");
Insert into acronimos(acronimo,expansao) values("VED","diâmetro diastólico");
Insert into acronimos(acronimo,expansao) values("VEDF","ventrículo esquerdo diástole final");
Insert into acronimos(acronimo,expansao) values("VES","diâmetro sistólico");
Insert into acronimos(acronimo,expansao) values("VESF","ventrículo esquerdo sístole final");
Insert into acronimos(acronimo,expansao) values("VSVE","via de saída do ventrículo esquerdo");
Insert into acronimos(acronimo,expansao) values("h/h","de hora em hora");
Insert into acronimos(acronimo,expansao) values("A2RV","alteração de repolarização ventricular");
Insert into acronimos(acronimo,expansao) values("AA2","aminoácidos");
Insert into acronimos(acronimo,expansao) values("ACE","artéria coronária esquerda");
Insert into acronimos(acronimo,expansao) values("ADS","amniocentese descompressiva seriada");
Insert into acronimos(acronimo,expansao) values("AI","angina instável");
Insert into acronimos(acronimo,expansao) values("AINEs","antiinflamatórios não-esteroidais");
Insert into acronimos(acronimo,expansao) values("ANGIO","angiografia");
Insert into acronimos(acronimo,expansao) values("ARA","antagonistas dos receptores da angiotensina");
Insert into acronimos(acronimo,expansao) values("ART","artéria");
Insert into acronimos(acronimo,expansao) values("AVEs","acidente vascular encefálico");
Insert into acronimos(acronimo,expansao) values("AVF","ante-verso-flexão");
Insert into acronimos(acronimo,expansao) values("B1","B1");
Insert into acronimos(acronimo,expansao) values("B3","terceira bulha");
Insert into acronimos(acronimo,expansao) values("B4","quarta bulha");
Insert into acronimos(acronimo,expansao) values("BBloq","beta-bloqueadores");
Insert into acronimos(acronimo,expansao) values("BC","bloco cirúrgico");
Insert into acronimos(acronimo,expansao) values("BCG","bacilo de Calmette-Guérin");
Insert into acronimos(acronimo,expansao) values("BCPs","broncopneumonias");
Insert into acronimos(acronimo,expansao) values("BDAS","bloqueios divisionais ântero-superiores");
Insert into acronimos(acronimo,expansao) values("BIPAP","pressão positiva em vias aéreas com dois níveis");
Insert into acronimos(acronimo,expansao) values("BNF","bulhas normofonéticos");
Insert into acronimos(acronimo,expansao) values("BT:41","bilirrubina total");
Insert into acronimos(acronimo,expansao) values("BZD","benzodiazepínicos");
Insert into acronimos(acronimo,expansao) values("BiPAP","pressão positiva em vias aéreas com dois níveis");
Insert into acronimos(acronimo,expansao) values("C1","cesariana 1");
Insert into acronimos(acronimo,expansao) values("CAt","avaliação crítica tópica");
Insert into acronimos(acronimo,expansao) values("CD34","grupo de diferenciação 34");
Insert into acronimos(acronimo,expansao) values("CHAd","concentrado de hemácias adulto");
Insert into acronimos(acronimo,expansao) values("CIC","cirurgia cardíaca");
Insert into acronimos(acronimo,expansao) values("CID","Classificação Internacional de Doenças");
Insert into acronimos(acronimo,expansao) values("CIP","carcinoma incidental da próstata");
Insert into acronimos(acronimo,expansao) values("CTi","centro de terapia intensiva");
Insert into acronimos(acronimo,expansao) values("CVE","cardioversão elétrica");
Insert into acronimos(acronimo,expansao) values("CVM","contração voluntária máxima");
Insert into acronimos(acronimo,expansao) values("Ca2","cálcio");
Insert into acronimos(acronimo,expansao) values("CaT","avaliação crítica tópica");
Insert into acronimos(acronimo,expansao) values("D14","dia 14");
Insert into acronimos(acronimo,expansao) values("D4","dia 4");
Insert into acronimos(acronimo,expansao) values("DA/Dg","descendente anterior / primeira diagonal");
Insert into acronimos(acronimo,expansao) values("DBP","diâmetro biparietal");
Insert into acronimos(acronimo,expansao) values("DHEA","deidroepiandrosterona");
Insert into acronimos(acronimo,expansao) values("DIU","dispositivo intra-uterino");
Insert into acronimos(acronimo,expansao) values("DM-2","diabete melitus tipo 2");
Insert into acronimos(acronimo,expansao) values("DMII","diabete melitus tipo 2");
Insert into acronimos(acronimo,expansao) values("DP-CD","diagonal posterior - coronária direita");
Insert into acronimos(acronimo,expansao) values("DPP","descolamento prematuro de placenta");
Insert into acronimos(acronimo,expansao) values("DPT","espessamento peritoneal difuso");
Insert into acronimos(acronimo,expansao) values("DTS","dose total semanal");
Insert into acronimos(acronimo,expansao) values("DVR","distúrbio ventilatório restritivo");
Insert into acronimos(acronimo,expansao) values("Dg-DA","primeira diagonal / descendente anterior");
Insert into acronimos(acronimo,expansao) values("Dg1","primeira diagonal 1");
Insert into acronimos(acronimo,expansao) values("Dm2","diabete melitus tipo 2");
Insert into acronimos(acronimo,expansao) values("E-D","esquerda-direita");
Insert into acronimos(acronimo,expansao) values("ECGŽs","ecografias");
Insert into acronimos(acronimo,expansao) values("ECT","eletroconvulsoterapia");
Insert into acronimos(acronimo,expansao) values("EDSS","escala ampliada do estado de incapacidade");
Insert into acronimos(acronimo,expansao) values("EFV","efavirenz");
Insert into acronimos(acronimo,expansao) values("EME","emergência");
Insert into acronimos(acronimo,expansao) values("EMEP","emergência pediátrica");
Insert into acronimos(acronimo,expansao) values("EP","epitélio pigmentado");
Insert into acronimos(acronimo,expansao) values("FCmáx","função cardíaca máxima");
Insert into acronimos(acronimo,expansao) values("FEJ","fração de ejeção");
Insert into acronimos(acronimo,expansao) values("FEM","feminino");
Insert into acronimos(acronimo,expansao) values("FEV","fevereiro");
Insert into acronimos(acronimo,expansao) values("FEj","fração de ejeção");
Insert into acronimos(acronimo,expansao) values("FH","formação do hipocampo");
Insert into acronimos(acronimo,expansao) values("FID","fossa ilíaca direita");
Insert into acronimos(acronimo,expansao) values("FSV","fundo de saco vaginal");
Insert into acronimos(acronimo,expansao) values("G4","gestação 4");
Insert into acronimos(acronimo,expansao) values("G6PD","glicose-6-fosfato dehidrogenase");
Insert into acronimos(acronimo,expansao) values("GI","gastro intestinal");
Insert into acronimos(acronimo,expansao) values("GNMP","glomerulonefrite membrano-proliferativa");
Insert into acronimos(acronimo,expansao) values("GRAFT","Graft");
Insert into acronimos(acronimo,expansao) values("GRAM","gram");
Insert into acronimos(acronimo,expansao) values("GT","glutariltransferase");
Insert into acronimos(acronimo,expansao) values("GTS","gotas");
Insert into acronimos(acronimo,expansao) values("HAS,e","hipertensão arterial sistêmica");
Insert into acronimos(acronimo,expansao) values("HBAE","hemibloqueio anterior esquerdo");
Insert into acronimos(acronimo,expansao) values("HBP","hiperplasia benigna da próstata");
Insert into acronimos(acronimo,expansao) values("HBs","vírus da hepatite B");
Insert into acronimos(acronimo,expansao) values("HCSA","Hospital da Criança Santo Antônio");
Insert into acronimos(acronimo,expansao) values("HIC","hemorragia intracraniana");
Insert into acronimos(acronimo,expansao) values("HM","hipertermia maligna");
Insert into acronimos(acronimo,expansao) values("HMCs","hemoculturas");
Insert into acronimos(acronimo,expansao) values("HNF","heparina não-fracionada");
Insert into acronimos(acronimo,expansao) values("HTC","hematócrito");
Insert into acronimos(acronimo,expansao) values("HX","histórico");
Insert into acronimos(acronimo,expansao) values("Ht/Hb","hematócrito/hemoglobina");
Insert into acronimos(acronimo,expansao) values("IA","infarto agudo");
Insert into acronimos(acronimo,expansao) values("IAM's","infartos agudos do miocárdio");
Insert into acronimos(acronimo,expansao) values("IF","forma indeterminada");
Insert into acronimos(acronimo,expansao) values("IFN","interferon alfa-recombinante");
Insert into acronimos(acronimo,expansao) values("IMT","calibre intermediário da carótida");
Insert into acronimos(acronimo,expansao) values("IOT","intubação orotraqueal");
Insert into acronimos(acronimo,expansao) values("IPC","índice de potencial de contaminação");
Insert into acronimos(acronimo,expansao) values("ISHAK","Ishak");
Insert into acronimos(acronimo,expansao) values("ISRS","inibidor seletivo da recaptação de serotonina");
Insert into acronimos(acronimo,expansao) values("ITC","insuficiência tricúspide");
Insert into acronimos(acronimo,expansao) values("IVa","veia interventricular anterior");
Insert into acronimos(acronimo,expansao) values("IX","9");
Insert into acronimos(acronimo,expansao) values("K2","potássio");
Insert into acronimos(acronimo,expansao) values("L2-L3","lombar 2 - lombar 3");
Insert into acronimos(acronimo,expansao) values("L3","lombar 3");
Insert into acronimos(acronimo,expansao) values("L4","lombar 4");
Insert into acronimos(acronimo,expansao) values("L4-L5","lombar 4 - lombar 5");
Insert into acronimos(acronimo,expansao) values("L5-S1","lombar 5 - sacro 1");
Insert into acronimos(acronimo,expansao) values("LE","laparotomia exploradora");
Insert into acronimos(acronimo,expansao) values("LFN","linfonodos");
Insert into acronimos(acronimo,expansao) values("LI","liquido intersticial");
Insert into acronimos(acronimo,expansao) values("LLA","leucemia linfocítica aguda");
Insert into acronimos(acronimo,expansao) values("LLC","leucemia linfocítica crônica");
Insert into acronimos(acronimo,expansao) values("LMC","leucemia mielóide crônica");
Insert into acronimos(acronimo,expansao) values("LN","linfonodo");
Insert into acronimos(acronimo,expansao) values("LNH","linfoma não-Hodgkin");
Insert into acronimos(acronimo,expansao) values("LQR","líquor");
Insert into acronimos(acronimo,expansao) values("LUTS","sintomas do trato urinário inferior");
Insert into acronimos(acronimo,expansao) values("MELD","modelo para doença hepática terminal");
Insert into acronimos(acronimo,expansao) values("MF","microorganismos filamentosos");
Insert into acronimos(acronimo,expansao) values("MGCx","ramo marginal da artéria circunflexa");
Insert into acronimos(acronimo,expansao) values("MGLIS","artéria coronária marginal localizada intrastent");
Insert into acronimos(acronimo,expansao) values("MMG","mamografia");
Insert into acronimos(acronimo,expansao) values("MMSS","membros superiores");
Insert into acronimos(acronimo,expansao) values("MSS","membros superiores");
Insert into acronimos(acronimo,expansao) values("MSSA","Staphylococcus aureus sensível à meticilin");
Insert into acronimos(acronimo,expansao) values("MSs","membros superiores");
Insert into acronimos(acronimo,expansao) values("Mg1","primeira marginal");
Insert into acronimos(acronimo,expansao) values("MsSs","membros superiores");
Insert into acronimos(acronimo,expansao) values("NAC","neuropatia autonômica cardiovascular");
Insert into acronimos(acronimo,expansao) values("NAN","leite NAN");
Insert into acronimos(acronimo,expansao) values("ND","nefropatia diabética");
Insert into acronimos(acronimo,expansao) values("NOV","novembro");
Insert into acronimos(acronimo,expansao) values("NYHA","Associação do Coração de Nova York");
Insert into acronimos(acronimo,expansao) values("Na3","potássio");
Insert into acronimos(acronimo,expansao) values("OEA","otoemisiones acústicas");
Insert into acronimos(acronimo,expansao) values("OFT","oftalmologia");
Insert into acronimos(acronimo,expansao) values("OUT","outubro");
Insert into acronimos(acronimo,expansao) values("P4","parto 4");
Insert into acronimos(acronimo,expansao) values("PAAf","punção aspirativa por agulha fina");
Insert into acronimos(acronimo,expansao) values("PAC","pneumonia adquirida na comunidade");
Insert into acronimos(acronimo,expansao) values("PASP","pressão sistólica da artéria pulmonar");
Insert into acronimos(acronimo,expansao) values("PAVM","pneumonia associada à ventilação mecânica");
Insert into acronimos(acronimo,expansao) values("PFE","peso fetal estimado");
Insert into acronimos(acronimo,expansao) values("PICC","catéter central de inserção periférica");
Insert into acronimos(acronimo,expansao) values("PNI","psiconeuroimunologia");
Insert into acronimos(acronimo,expansao) values("PNM","pneumonia");
Insert into acronimos(acronimo,expansao) values("PNP","polineuropatia");
Insert into acronimos(acronimo,expansao) values("PO2","pressão parcial do oxigênio");
Insert into acronimos(acronimo,expansao) values("POP","procedimento operacional padrão");
Insert into acronimos(acronimo,expansao) values("PS-MG","Pronto Socorro de Minas Gerais");
Insert into acronimos(acronimo,expansao) values("PSG","polissonografia");
Insert into acronimos(acronimo,expansao) values("PUCRS","Pontifícia Universidade Católica do Rio Grande do Sul");
Insert into acronimos(acronimo,expansao) values("PVM","prolapso da valva mitral");
Insert into acronimos(acronimo,expansao) values("R3","residente 3");
Insert into acronimos(acronimo,expansao) values("RCR","ressuscitação cardio-respiratória");
Insert into acronimos(acronimo,expansao) values("RCT","rastreamento corporal total com radioiodo");
Insert into acronimos(acronimo,expansao) values("RDNPM","retardo do desenvolvimento neuropsicomotor");
Insert into acronimos(acronimo,expansao) values("RDP","retinopatia diabética proliferativa");
Insert into acronimos(acronimo,expansao) values("RE","retículo esquerdo");
Insert into acronimos(acronimo,expansao) values("RHJ","refluxo hepato-jugular");
Insert into acronimos(acronimo,expansao) values("RR","risco relativo");
Insert into acronimos(acronimo,expansao) values("RT","radioterapia");
Insert into acronimos(acronimo,expansao) values("RTX","neurotoxina resiniferatoxina");
Insert into acronimos(acronimo,expansao) values("RUB","rubéola");
Insert into acronimos(acronimo,expansao) values("S1","sacro 1");
Insert into acronimos(acronimo,expansao) values("SAD","sobrecarga atrial direita");
Insert into acronimos(acronimo,expansao) values("SAE","sobrecarga atrial esquerda");
Insert into acronimos(acronimo,expansao) values("SCD","seio coronário distal");
Insert into acronimos(acronimo,expansao) values("SMD","síndrome mielodisplásica");
Insert into acronimos(acronimo,expansao) values("SOG","sonda orogástrica");
Insert into acronimos(acronimo,expansao) values("SP","sala de politraumatizados");
Insert into acronimos(acronimo,expansao) values("SPECT","spect cardíaco");
Insert into acronimos(acronimo,expansao) values("SULFA","sulfametoxazol");
Insert into acronimos(acronimo,expansao) values("T2","segunda torácica");
Insert into acronimos(acronimo,expansao) values("T12","torácica 12");
Insert into acronimos(acronimo,expansao) values("T4L","tetraiodotironina");
Insert into acronimos(acronimo,expansao) values("T:0,7","troponina 0");
Insert into acronimos(acronimo,expansao) values("T:2,1","troponina 2");
Insert into acronimos(acronimo,expansao) values("THB","transtorno de humor bipolar");
Insert into acronimos(acronimo,expansao) values("TIG5","taxa de infusão de glicose");
Insert into acronimos(acronimo,expansao) values("TISQ","tempo de isquemia");
Insert into acronimos(acronimo,expansao) values("TJV","transfusão intravascular");
Insert into acronimos(acronimo,expansao) values("TMP","trimetoprim");
Insert into acronimos(acronimo,expansao) values("TRAM","retalho miocutâneo transverso abdominal");
Insert into acronimos(acronimo,expansao) values("TSC","tiragem subcostal");
Insert into acronimos(acronimo,expansao) values("TSE","spin-eco turbo");
Insert into acronimos(acronimo,expansao) values("TSH:5","hormônio tíreo-estimulante 5");
Insert into acronimos(acronimo,expansao) values("TTG","teste de tolerância a glicose");
Insert into acronimos(acronimo,expansao) values("TU","trato urinário");
Insert into acronimos(acronimo,expansao) values("TVS","taquicardias ventriculares monomórficas sustentadas");
Insert into acronimos(acronimo,expansao) values("TnT","troponina");
Insert into acronimos(acronimo,expansao) values("TxH","transplante hepático");
Insert into acronimos(acronimo,expansao) values("UCC","Unidade de Cardiopatias Congênitas");
Insert into acronimos(acronimo,expansao) values("UFC","unidades formadoras de colônia");
Insert into acronimos(acronimo,expansao) values("UR","uréia");
Insert into acronimos(acronimo,expansao) values("URO","urocultura");
Insert into acronimos(acronimo,expansao) values("VA-AD","valvula anterior do átrio direito");
Insert into acronimos(acronimo,expansao) values("VANCO","vancomicina");
Insert into acronimos(acronimo,expansao) values("VAS","vias aéreas superiores");
Insert into acronimos(acronimo,expansao) values("VD17","ventrículo direito 17");
Insert into acronimos(acronimo,expansao) values("VEd","diástole do ventrículo esquerdo");
Insert into acronimos(acronimo,expansao) values("VEs","sístole do ventrículo esquerdo");
Insert into acronimos(acronimo,expansao) values("VMA","ácido vanilmandélico");
Insert into acronimos(acronimo,expansao) values("VR","via retal");
Insert into acronimos(acronimo,expansao) values("Vo2","volume de oxigênio");
Insert into acronimos(acronimo,expansao) values("XII","12");
Insert into acronimos(acronimo,expansao) values("b2","beta 2");
Insert into acronimos(acronimo,expansao) values("g/dia","grama/dia");
Insert into acronimos(acronimo,expansao) values("mVE","massa ventricular esquerda");
Insert into acronimos(acronimo,expansao) values("mnmHg","milímetros de mercúrio");
Insert into acronimos(acronimo,expansao) values("pCO2","pressão de dióxido de carbono");
Insert into acronimos(acronimo,expansao) values("r-x","raio X");
Insert into acronimos(acronimo,expansao) values("s/n","se necessário");
Insert into acronimos(acronimo,expansao) values("satO2","saturação de oxigênio");
Insert into acronimos(acronimo,expansao) values("vO","via oral");

#Adiciona texto da sentença
ALTER TABLE `sentencas`
	ADD COLUMN `sentenca` VARCHAR(1000) NOT NULL AFTER `ordem`;

#Coluna adjudicador
ALTER TABLE `anotacoes`
	ADD COLUMN `adjudicador` TINYINT(1) NOT NULL AFTER `status`;
	


#Ultimo acesso do usuario
ALTER TABLE `usuarios`
	ADD COLUMN `ultimo_acesso` DATETIME NULL DEFAULT NULL AFTER `perfil_id`;

#Definição de status das tags e tipo(não-definido ou abreviatura) que tem comportamentos especiais
ALTER TABLE `tags`
	ADD COLUMN `status` ENUM('A','I') NOT NULL DEFAULT 'A' AFTER `tag`,
	ADD COLUMN `tipo` ENUM('N','A') NULL DEFAULT NULL COMMENT 'N = Not-defined - A = Abbreviation' AFTER `status`;
	
-- Complemento do anterior - Não é obrigatória a execuação. 
UPDATE `annotationtool`.`tags` SET `tipo`='N' WHERE  `id`=20;
UPDATE `annotationtool`.`tags` SET `tipo`='A' WHERE  `id`=17;

-- Definição de cor das tags - 07/11/2016 by Lucas
ALTER TABLE `tags`
	ADD COLUMN `cor` CHAR(6) NULL DEFAULT 'e4e4e4' COMMENT 'Hexadecimal da cor' AFTER `tipo`;

	
ALTER TABLE `tags`
	ADD COLUMN `extra_id` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Campo para informação extra, no caso usando para as ids da umls' AFTER `tag`;
	
ALTER TABLE `tags`
	ADD COLUMN `hierarquia` VARCHAR(20) NULL AFTER `extra_id`;    

-- Definição dos TIPOS de tags que não sejam da UMLS/SNOMED
ALTER TABLE `tags`
	CHANGE COLUMN `tipo` `tipo` ENUM('U','A','N','M') NULL DEFAULT NULL COMMENT 'U = undefined - A = Abbreviation - N = Negation - M = Modificador - NULL = Normal' AFTER `status`;
	
-- Coluna de tradução
ALTER TABLE `tags`
	ADD COLUMN `traducao` VARCHAR(255) NULL AFTER `tag`;
    
#Permissões
ALTER TABLE `usuarios`
	ADD COLUMN `permissao` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 - Nenhuma, 1 - Revisor, 2 - Anotador, 4 - Adjudicador, 8 - Administrador' AFTER `senha`;
UPDATE `annotationtool`.`usuarios` SET `permissao`=15 WHERE  `id`=1;
ALTER TABLE `usuarios`
	DROP COLUMN `perfil_id`,
	DROP FOREIGN KEY `FK_perfil_usuario`;
	
#Tabela permissões
DROP TABLE IF EXISTS `permissoes`;
CREATE TABLE `permissoes` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`pagina` CHAR(255) NOT NULL DEFAULT '0',
	`permissao` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`)
);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/painel.jsp', 15);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/textImport.jsp', 8);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/textList.jsp', 15);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/textReview.jsp', 1);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/textAdjudication.jsp', 4);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/userManagement.jsp', 8);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/projectManagement.jsp', 8);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/newUser.jsp', 8);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/newProject.jsp', 8);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/userProprieties.jsp', 8);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/projectProprieties.jsp', 8);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/projectSelection.jsp', 15);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/textExport.jsp', 8);
INSERT INTO `annotationtool`.`permissoes` (`pagina`, `permissao`) VALUES ('/textAnnotation.jsp', 2);

#Projeto dummy
INSERT INTO `annotationtool`.`projetos` (id,`nome`) VALUES (1,'Projeto teste');

-- DEFINIÇÃO DAS TAGS UMLS/SNOMED - 16/01/2017
DELETE FROM tags;
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (1, 1, 'Organism', 'T001', 'A1.1', 'A', NULL, '14E73A');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (2, 1, 'Plant', 'T002', 'A1.1.3.3', 'A', NULL, '35F461');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (3, 1, 'Fungus', 'T004', 'A1.1.3.2', 'A', NULL, '3679B8');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (4, 1, 'Virus', 'T005', 'A1.1.4', 'A', NULL, '6E8374');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (5, 1, 'Bacterium', 'T007', 'A1.1.2', 'A', NULL, '53F71F');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (6, 1, 'Animal', 'T008', 'A1.1.3.1', 'A', NULL, '584940');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (7, 1, 'Vertebrate', 'T010', 'A1.1.3.1.1', 'A', NULL, '24F262');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (8, 1, 'Amphibian', 'T011', 'A1.1.3.1.1.1', 'A', NULL, '4876AB');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (9, 1, 'Bird', 'T012', 'A1.1.3.1.1.2', 'A', NULL, '62E3AF');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (10, 1, 'Fish', 'T013', 'A1.1.3.1.1.3', 'A', NULL, '7C77EB');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (11, 1, 'Reptile', 'T014', 'A1.1.3.1.1.5', 'A', NULL, '147F8A');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (12, 1, 'Mammal', 'T015', 'A1.1.3.1.1.4', 'A', NULL, '2242F2');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (13, 1, 'Human', 'T016', 'A1.1.3.1.1.4.1', 'A', NULL, '6DD01C');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (14, 1, 'Anatomical Structure', 'T017', 'A1.2', 'A', NULL, '8D1AB4');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (15, 1, 'Embryonic Structure', 'T018', 'A1.2.1', 'A', NULL, '46E833');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (16, 1, 'Congenital Abnormality', 'T019', 'A1.2.2.1', 'A', NULL, '53CF64');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (17, 1, 'Acquired Abnormality', 'T020', 'A1.2.2.2', 'A', NULL, '35BDDB');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (18, 1, 'Fully Formed Anatomical Structure', 'T021', 'A1.2.3', 'A', NULL, '11471C');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (19, 1, 'Body System', 'T022', 'A2.1.4.1', 'A', NULL, '4DC079');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (20, 1, 'Body Part, Organ, or Organ Component', 'T023', 'A1.2.3.1', 'A', NULL, '1FC00C');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (21, 1, 'Tissue', 'T024', 'A1.2.3.2', 'A', NULL, '4E1552');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (22, 1, 'Cell', 'T025', 'A1.2.3.3', 'A', NULL, '8E93F5');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (23, 1, 'Cell Component', 'T026', 'A1.2.3.4', 'A', NULL, '14E052');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (24, 1, 'Gene or Genome', 'T028', 'A1.2.3.5', 'A', NULL, '86693C');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (25, 1, 'Body Location or Region', 'T029', 'A2.1.5.2', 'A', NULL, '97A9B7');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (26, 1, 'Body Space or Junction', 'T030', 'A2.1.5.1', 'A', NULL, '31E7E0');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (27, 1, 'Body Substance', 'T031', 'A1.4.2', 'A', NULL, '63B73B');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (28, 1, 'Organism Attribute', 'T032', 'A2.3', 'A', NULL, '2BAF88');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (29, 1, 'Finding', 'T033', 'A2.2', 'A', NULL, '47DE78');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (30, 1, 'Laboratory or Test Result', 'T034', 'A2.2.1', 'A', NULL, '4BB33F');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (31, 1, 'Injury or Poisoning', 'T037', 'B2.3', 'A', NULL, '0A4E54');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (32, 1, 'Biologic Function', 'T038', 'B2.2.1', 'A', NULL, '819AE6');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (33, 1, 'Physiologic Function', 'T039', 'B2.2.1.1', 'A', NULL, '06C185');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (34, 1, 'Organism Function', 'T040', 'B2.2.1.1.1', 'A', NULL, '66BA65');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (35, 1, 'Mental Process', 'T041', 'B2.2.1.1.1.1', 'A', NULL, '239BEB');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (36, 1, 'Organ or Tissue Function', 'T042', 'B2.2.1.1.2', 'A', NULL, '1672E9');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (37, 1, 'Cell Function', 'T043', 'B2.2.1.1.3', 'A', NULL, '056ACE');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (38, 1, 'Molecular Function', 'T044', 'B2.2.1.1.4', 'A', NULL, '7053C8');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (39, 1, 'Genetic Function', 'T045', 'B2.2.1.1.4.1', 'A', NULL, '579F01');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (40, 1, 'Pathologic Function', 'T046', 'B2.2.1.2', 'A', NULL, '651FAC');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (41, 1, 'Disease or Syndrome', 'T047', 'B2.2.1.2.1', 'A', NULL, '5A2ADA');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (42, 1, 'Mental or Behavioral Dysfunction', 'T048', 'B2.2.1.2.1.1', 'A', NULL, '93773E');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (43, 1, 'Cell or Molecular Dysfunction', 'T049', 'B2.2.1.2.2', 'A', NULL, '09102A');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (44, 1, 'Experimental Model of Disease', 'T050', 'B2.2.1.2.3', 'A', NULL, '3CAE97');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (45, 1, 'Event', 'T051', 'B', 'A', NULL, '7BA1F4');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (46, 1, 'Activity', 'T052', 'B1', 'A', NULL, '82F100');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (47, 1, 'Behavior', 'T053', 'B1.1', 'A', NULL, '8338A5');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (48, 1, 'Social Behavior', 'T054', 'B1.1.1', 'A', NULL, '6EB1B8');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (49, 1, 'Individual Behavior', 'T055', 'B1.1.2', 'A', NULL, '07382A');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (50, 1, 'Daily or Recreational Activity', 'T056', 'B1.2', 'A', NULL, '0930AA');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (51, 1, 'Occupational Activity', 'T057', 'B1.3', 'A', NULL, '184AD5');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (52, 1, 'Health Care Activity', 'T058', 'B1.3.1', 'A', NULL, '5DE42C');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (53, 1, 'Laboratory Procedure', 'T059', 'B1.3.1.1', 'A', NULL, '5B675D');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (54, 1, 'Diagnostic Procedure', 'T060', 'B1.3.1.2', 'A', NULL, '16C1CD');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (55, 1, 'Therapeutic or Preventive Procedure', 'T061', 'B1.3.1.3', 'A', NULL, '90BFE9');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (56, 1, 'Research Activity', 'T062', 'B1.3.2', 'A', NULL, '2D2029');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (57, 1, 'Molecular Biology Research Technique', 'T063', 'B1.3.2.1', 'A', NULL, '608E11');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (58, 1, 'Governmental or Regulatory Activity', 'T064', 'B1.3.3', 'A', NULL, '2A38DC');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (59, 1, 'Educational Activity', 'T065', 'B1.3.4', 'A', NULL, '4A0897');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (60, 1, 'Machine Activity', 'T066', 'B1.4', 'A', NULL, '5AE9DF');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (61, 1, 'Phenomenon or Process', 'T067', 'B2', 'A', NULL, '4FE118');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (62, 1, 'Human-caused Phenomenon or Process', 'T068', 'B2.1', 'A', NULL, '7EA7D9');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (63, 1, 'Environmental Effect of Humans', 'T069', 'B2.1.1', 'A', NULL, '5876F5');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (64, 1, 'Natural Phenomenon or Process', 'T070', 'B2.2', 'A', NULL, '3E5B40');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (65, 1, 'Entity', 'T071', 'A', 'A', NULL, '2E6361');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (66, 1, 'Physical Object', 'T072', 'A1', 'A', NULL, '2CDF24');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (67, 1, 'Manufactured Object', 'T073', 'A1.3', 'A', NULL, '553192');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (68, 1, 'Medical Device', 'T074', 'A1.3.1', 'A', NULL, '8AC3EE');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (69, 1, 'Research Device', 'T075', 'A1.3.2', 'A', NULL, '8511F0');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (70, 1, 'Conceptual Entity', 'T077', 'A2', 'A', NULL, '607766');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (71, 1, 'Idea or Concept', 'T078', 'A2.1', 'A', NULL, '531F30');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (72, 1, 'Temporal Concept', 'T079', 'A2.1.1', 'A', NULL, '7E35BB');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (73, 1, 'Qualitative Concept', 'T080', 'A2.1.2', 'A', NULL, '4C821A');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (74, 1, 'Quantitative Concept', 'T081', 'A2.1.3', 'A', NULL, '03E953');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (75, 1, 'Spatial Concept', 'T082', 'A2.1.5', 'A', NULL, '5F354E');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (76, 1, 'Geographic Area', 'T083', 'A2.1.5.4', 'A', NULL, '068B0E');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (77, 1, 'Molecular Sequence', 'T085', 'A2.1.5.3', 'A', NULL, '34445B');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (78, 1, 'Nucleotide Sequence', 'T086', 'A2.1.5.3.1', 'A', NULL, '591E1E');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (79, 1, 'Amino Acid Sequence', 'T087', 'A2.1.5.3.2', 'A', NULL, '883304');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (80, 1, 'Carbohydrate Sequence', 'T088', 'A2.1.5.3.3', 'A', NULL, '6C77BB');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (81, 1, 'Regulation or Law', 'T089', 'A2.4.2', 'A', NULL, '85BD9B');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (82, 1, 'Occupation or Discipline', 'T090', 'A2.6', 'A', NULL, '261FD7');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (83, 1, 'Biomedical Occupation or Discipline', 'T091', 'A2.6.1', 'A', NULL, '5E9363');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (84, 1, 'Organization', 'T092', 'A2.7', 'A', NULL, '35546A');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (85, 1, 'Health Care Related Organization', 'T093', 'A2.7.1', 'A', NULL, '878268');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (86, 1, 'Professional Society', 'T094', 'A2.7.2', 'A', NULL, '3BCB4C');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (87, 1, 'Self-help or Relief Organization', 'T095', 'A2.7.3', 'A', NULL, '2D07C2');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (88, 1, 'Group', 'T096', 'A2.9', 'A', NULL, '2DC4E8');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (89, 1, 'Professional or Occupational Group', 'T097', 'A2.9.1', 'A', NULL, '5DC143');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (90, 1, 'Population Group', 'T098', 'A2.9.2', 'A', NULL, '1A4A99');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (91, 1, 'Family Group', 'T099', 'A2.9.3', 'A', NULL, '02C7B1');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (92, 1, 'Age Group', 'T100', 'A2.9.4', 'A', NULL, '579D2C');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (93, 1, 'Patient or Disabled Group', 'T101', 'A2.9.5', 'A', NULL, '7C8DC8');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (94, 1, 'Group Attribute', 'T102', 'A2.8', 'A', NULL, '36C067');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (95, 1, 'Chemical', 'T103', 'A1.4.1', 'A', NULL, '34AF29');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (96, 1, 'Chemical Viewed Structurally', 'T104', 'A1.4.1.2', 'A', NULL, '632A9B');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (97, 1, 'Organic Chemical', 'T109', 'A1.4.1.2.1', 'A', NULL, '209A89');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (98, 1, 'Nucleic Acid, Nucleoside, or Nucleotide', 'T114', 'A1.4.1.2.1.5', 'A', NULL, '121B60');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (99, 1, 'Amino Acid, Peptide, or Protein', 'T116', 'A1.4.1.2.1.7', 'A', NULL, '914FC2');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (100, 1, 'Chemical Viewed Functionally', 'T120', 'A1.4.1.1', 'A', NULL, '3DE2AA');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (101, 1, 'Pharmacologic Substance', 'T121', 'A1.4.1.1.1', 'A', NULL, '1A148E');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (102, 1, 'Biomedical or Dental Material', 'T122', 'A1.4.1.1.2', 'A', NULL, '61554A');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (103, 1, 'Biologically Active Substance', 'T123', 'A1.4.1.1.3', 'A', NULL, '673FC5');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (104, 1, 'Hormone', 'T125', 'A1.4.1.1.3.2', 'A', NULL, '47A87E');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (105, 1, 'Enzyme', 'T126', 'A1.4.1.1.3.3', 'A', NULL, '308B25');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (106, 1, 'Vitamin', 'T127', 'A1.4.1.1.3.4', 'A', NULL, '1BBE41');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (107, 1, 'Immunologic Factor', 'T129', 'A1.4.1.1.3.5', 'A', NULL, '91AC58');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (108, 1, 'Indicator, Reagent, or Diagnostic Aid', 'T130', 'A1.4.1.1.4', 'A', NULL, '22C8F3');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (109, 1, 'Hazardous or Poisonous Substance', 'T131', 'A1.4.1.1.5', 'A', NULL, '2A14B8');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (110, 1, 'Substance', 'T167', 'A1.4', 'A', NULL, '6A0CBE');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (111, 1, 'Food', 'T168', 'A1.4.3', 'A', NULL, '62D48E');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (112, 1, 'Functional Concept', 'T169', 'A2.1.4', 'A', NULL, '176A0D');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (113, 1, 'Intellectual Product', 'T170', 'A2.4', 'A', NULL, '7DC199');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (114, 1, 'Language', 'T171', 'A2.5', 'A', NULL, '64C654');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (115, 1, 'Sign or Symptom', 'T184', 'A2.2.2', 'A', NULL, '7E9AD9');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (116, 1, 'Classification', 'T185', 'A2.4.1', 'A', NULL, '198641');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (117, 1, 'Anatomical Abnormality', 'T190', 'A1.2.2', 'A', NULL, '34FBBB');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (118, 1, 'Neoplastic Process', 'T191', 'B2.2.1.2.1.2', 'A', NULL, '23C166');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (119, 1, 'Receptor', 'T192', 'A1.4.1.1.3.6', 'A', NULL, '13D3CB');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (120, 1, 'Archaeon', 'T194', 'A1.1.1', 'A', NULL, '907547');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (121, 1, 'Antibiotic', 'T195', 'A1.4.1.1.1.1', 'A', NULL, '347501');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (122, 1, 'Element, Ion, or Isotope', 'T196', 'A1.4.1.2.3', 'A', NULL, '861630');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (123, 1, 'Inorganic Chemical', 'T197', 'A1.4.1.2.2', 'A', NULL, '374C6C');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (124, 1, 'Clinical Drug', 'T200', 'A1.3.3', 'A', NULL, '1AD20E');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (125, 1, 'Clinical Attribute', 'T201', 'A2.3.1', 'A', NULL, '78CB81');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (126, 1, 'Drug Delivery Device', 'T203', 'A1.3.1.1', 'A', NULL, '41BFDC');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (127, 1, 'Eukaryote', 'T204', 'A1.1.3', 'A', NULL, '76F349');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `traducao`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (128, 1, 'Negation', 'Negação', NULL, NULL, 'A', 'N', 'FF0000');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `traducao`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (130, 1, 'Modifier', 'Modificador', NULL, NULL, 'A', 'M', 'e4e4e4');
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `traducao`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (131, 1, 'Abbreviation', 'Abreviatura', NULL, NULL, 'A', 'A', '808000');
INSERT INTO `tags` (`projeto_id`, `tag`, `traducao`, `cor`) VALUES (1, 'DÚVIDA', 'DÚVIDA', 'ff00bf');

--Definição dos TIPOS de tags que não sejam da UMLS/SNOMED
ALTER TABLE `tags`
	CHANGE COLUMN `tipo` `tipo` ENUM('U','A','N','M') NULL DEFAULT NULL COMMENT 'U = undefined - A = Abbreviation - N = Negation - M = Modificador - NULL = Normal' AFTER `status`;
	
--Coluna de tradução
ALTER TABLE `tags`
	ADD COLUMN `traducao` VARCHAR(255) NOT NULL AFTER `tag`;
	
--COluna de abreviatura nas anotações
INSERT INTO `tags` (`id`, `projeto_id`, `tag`, `traducao`, `extra_id`, `hierarquia`, `status`, `tipo`, `cor`) VALUES (131, 1, 'Abbreviation', 'Abreviatura', NULL, NULL, 'A', 'A', '808000');	
-- COluna de abreviatura nas anotações
ALTER TABLE `anotacoes`
	ADD COLUMN `abreviatura` VARCHAR(255) NULL AFTER `dataanotacao`;
ALTER TABLE `anotacoes`
	ADD COLUMN `umlscui` CHAR(8) NULL DEFAULT NULL AFTER `abreviatura`,
	ADD COLUMN `snomedctid` CHAR(9) NULL DEFAULT NULL AFTER `umlscui`;
	
-- Tabela de TIPOS DE RELACIONAMENTOS
CREATE TABLE `tiposrelacionamentos` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`nome` VARCHAR(255) NOT NULL,
	`traducao` VARCHAR(255) NULL,
	`extra_id` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Campo para informação extra, no caso usando para as ids da umls',
	`hierarquia` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Campo para string que define hierarquia dos tipos semanticos da UMLS/SNOMED',
	`status` ENUM('A','I') NOT NULL DEFAULT 'A' COMMENT 'A = Active - I = Inactive',
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
ALTER TABLE `tiposrelacionamentos`
	ADD COLUMN `projeto_id` INT(10) UNSIGNED NOT NULL AFTER `id`;

-- Adicionado TIPO DE RELACIONAMENTO na tabela que guarda RELACIONAMENTOS
ALTER TABLE `relacionamentos`
	ADD COLUMN `tiporelacionamento_id` INT(10) UNSIGNED NULL AFTER `anotacao2_id`,
	ADD CONSTRAINT `FK_tiporelacionamento` FOREIGN KEY (`tiporelacionamento_id`) REFERENCES `tiposrelacionamentos` (`id`);

-- TIPOS DE RELACIONAMENTO
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (47, 1, 'isa', '', 'T186', 'H', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (35, 1, 'associated_with', '', 'T166', 'R', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (1, 1, 'physically_related_to', '', 'T132', 'R1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (2, 1, 'part_of', '', 'T133', 'R1.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (36, 1, 'consists_of', '', 'T172', 'R1.2', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (3, 1, 'contains', '', 'T134', 'R1.3', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (38, 1, 'connected_to', '', 'T174', 'R1.4', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (39, 1, 'interconnects', '', 'T175', 'R1.5', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (52, 1, 'branch_of', '', 'T198', 'R1.6', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (53, 1, 'tributary_of', '', 'T199', 'R1.7', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (54, 1, 'ingredient_of', '', 'T202', 'R1.8', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (50, 1, 'spatially_related_to', '', 'T189', 'R2', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (4, 1, 'location_of', '', 'T135', 'R2.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (37, 1, 'adjacent_to', '', 'T173', 'R2.2', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (40, 1, 'surrounds', '', 'T176', 'R2.3', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (41, 1, 'traverses', '', 'T177', 'R2.4', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (8, 1, 'functionally_related_to', '', 'T139', 'R3', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (20, 1, 'affects', '', 'T151', 'R3.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (22, 1, 'manages', '', 'T153', 'R3.1.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (23, 1, 'treats', '', 'T154', 'R3.1.2', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (15, 1, 'disrupts', '', 'T146', 'R3.1.3', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (18, 1, 'complicates', '', 'T149', 'R3.1.4', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (11, 1, 'interacts_with', '', 'T142', 'R3.1.5', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (17, 1, 'prevents', '', 'T148', 'R3.1.6', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (48, 1, 'brings_about', '', 'T187', 'R3.2', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (13, 1, 'produces', '', 'T144', 'R3.2.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (16, 1, 'causes', '', 'T147', 'R3.2.2', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (49, 1, 'performs', '', 'T188', 'R3.3', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (10, 1, 'carries_out', '', 'T141', 'R3.3.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (14, 1, 'exhibits', '', 'T145', 'R3.3.2', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (12, 1, 'practices', '', 'T143', 'R3.3.3', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (21, 1, 'occurs_in', '', 'T152', 'R3.4', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (9, 1, 'process_of', '', 'T140', 'R3.4.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (24, 1, 'uses', '', 'T155', 'R3.5', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (19, 1, 'manifestation_of', '', 'T150', 'R3.6', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (25, 1, 'indicates', '', 'T156', 'R3.7', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (26, 1, 'result_of', '', 'T157', 'R3.8', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (5, 1, 'temporally_related_to', '', 'T136', 'R4', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (6, 1, 'co-occurs_with', '', 'T137', 'R4.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (7, 1, 'precedes', '', 'T138', 'R4.2', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (27, 1, 'conceptually_related_to', '', 'T158', 'R5', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (30, 1, 'evaluation_of', '', 'T161', 'R5.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (46, 1, 'method_of', '', 'T183', 'R5.10', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (29, 1, 'conceptual_part_of', '', 'T160', 'R5.11', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (34, 1, 'issue_in', '', 'T165', 'R5.12', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (44, 1, 'degree_of', '', 'T180', 'R5.2', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (51, 1, 'analyzes', '', 'T193', 'R5.3', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (33, 1, 'assesses_effect_of', '', 'T164', 'R5.3.1', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (45, 1, 'measurement_of', '', 'T182', 'R5.4', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (31, 1, 'measures', '', 'T162', 'R5.5', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (32, 1, 'diagnoses', '', 'T163', 'R5.6', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (28, 1, 'property_of', '', 'T159', 'R5.7', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (42, 1, 'derivative_of', '', 'T178', 'R5.8', 'A');
INSERT INTO `tiposrelacionamentos` (`id`, `projeto_id`, `nome`, `traducao`, `extra_id`, `hierarquia`, `status`) VALUES (43, 1, 'developmental_form_of', '', 'T179', 'R5.9', 'A');
INSERT INTO `tiposrelacionamentos` (`projeto_id`, `nome`) VALUES (1, 'negation_of');
UPDATE `tiposrelacionamentos` SET `hierarquia`='A1' WHERE  `id`=55;

--Redefinição da tabela de relacionamentos
ALTER TABLE `relacionamentos`
	ALTER `anotacao1_id` DROP DEFAULT,
	ALTER `anotacao2_id` DROP DEFAULT;
ALTER TABLE `relacionamentos`
	CHANGE COLUMN `anotacao1_id` `tokens1` VARCHAR(100) NOT NULL COMMENT 'TOKEN_IDs do termo 1 - Separados por vírgula (Necessário para termos compostos)' AFTER `id`,
	CHANGE COLUMN `anotacao2_id` `tokens2` VARCHAR(100) NOT NULL COMMENT 'TOKEN_IDs do termo 2 - Separados por vírgula (Necessário para termos compostos)' AFTER `tokens1`,
	DROP FOREIGN KEY `FK_anotacao_relacionamento1`,
	DROP FOREIGN KEY `FK_anotacao_relacionamento2`;

-- Tabela de alocação de usuarios nos projetos
CREATE TABLE `alocacaoprojeto` (
	`projeto_id` INT(10) UNSIGNED NOT NULL,
	`usuario_id` INT(10) UNSIGNED NOT NULL,
	INDEX `FK__projetos` (`projeto_id`),
	INDEX `FK__usuarios` (`usuario_id`),
	CONSTRAINT `FK__projetos` FOREIGN KEY (`projeto_id`) REFERENCES `projetos` (`id`),
	CONSTRAINT `FK__usuarios` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
)
COMMENT='Tabela de relacionamento entre usuário e projeto'
;

-- Tabela de alocacao de usuarios para os textos

CREATE TABLE `alocacaotexto` (
	`projeto_id` INT(10) UNSIGNED NOT NULL,
	`texto_id` INT(10) UNSIGNED NOT NULL,
	`usuario_id` INT(10) UNSIGNED NOT NULL,
	INDEX `FK_alocacaotexto_textos` (`projeto_id`),
	INDEX `FK_alocacaotexto_textos_2` (`texto_id`),
	INDEX `FK_alocacaotexto_usuarios` (`usuario_id`),
	CONSTRAINT `FK_alocacaotexto_textos` FOREIGN KEY (`projeto_id`) REFERENCES `textos` (`projeto_id`),
	CONSTRAINT `FK_alocacaotexto_textos_2` FOREIGN KEY (`texto_id`) REFERENCES `textos` (`id`),
	CONSTRAINT `FK_alocacaotexto_usuarios` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
)
COMMENT='Tabela de relacionamento entre usuário e texto'
;

--View para estatísticas de termos compostos
CREATE OR REPLACE VIEW termoscompostos AS
	SELECT DISTINCT 
		a.anotador_id, a.termocomposto_id, GROUP_CONCAT(t.token SEPARATOR " ") as termocomposto_desc, GROUP_CONCAT(t.id) as tokens_id, (SELECT GROUP_CONCAT(DISTINCT(tag_id)) FROM anotacoes a2 WHERE a2.termocomposto_id = a.termocomposto_id) as tags_id
	FROM 
		anotacoes a 
	INNER JOIN tokens t ON (a.token_id = t.id) 
	WHERE 
		a.termocomposto_id IS NOT NULL
	GROUP BY
		a.termocomposto_id, a.tag_id
	ORDER BY
		termocomposto_desc

--Criação de índice para procurar anotações e adjudicações
ALTER TABLE `anotacoes`
	ADD INDEX `IDX_adjudicador` (`adjudicador`);
	
--Alteração na VIEW de estatísticas
CREATE OR REPLACE VIEW termoscompostos AS
	SELECT DISTINCT 
		a.anotador_id, a.termocomposto_id, GROUP_CONCAT(t.token SEPARATOR " ") as termocomposto_desc, GROUP_CONCAT(t.id) as tokens_id, (SELECT GROUP_CONCAT(DISTINCT(tag_id)) FROM anotacoes a2 WHERE a2.termocomposto_id = a.termocomposto_id) as tags_id
	FROM 
		anotacoes a 
	INNER JOIN tokens t ON (a.token_id = t.id) 
	WHERE 
		a.adjudicador = 0 AND a.termocomposto_id IS NOT NULL
	GROUP BY
		a.termocomposto_id, a.tag_id
	ORDER BY
		termocomposto_desc
		
-- Criação de tabela para estatísticas, a view estava muito lenta - Deve ser atualizada regularmente
CREATE TABLE `termoscompostostable` (
  `anotador_id` int(10) unsigned NOT NULL,
  `termocomposto_id` char(36) DEFAULT NULL,
  `termocomposto_desc` text NOT NULL,
  `tokens_id` varchar(255) NOT NULL,
  `tags_id` varchar(255) NOT NULL,
  KEY `Index 1` (`termocomposto_id`),
  KEY `Index 2` (`anotador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para ser regularmente atualizada com as estatísticas'

--Popular tabela de estatísticas
INSERT termoscompostostable (anotador_id, termocomposto_id, termocomposto_desc, tokens_id, tags_id)
select distinct `a`.`anotador_id` AS `anotador_id`,`a`.`termocomposto_id` AS `termocomposto_id`,group_concat(`t`.`token` separator ' ') AS `termocomposto_desc`,group_concat(`t`.`id` separator ',') AS `tokens_id`,(select group_concat(distinct `a2`.`tag_id` separator ',') from `anotacoes` `a2` where (`a2`.`termocomposto_id` = `a`.`termocomposto_id`)) AS `tags_id` from (`anotacoes` `a` join `tokens` `t` on((`a`.`token_id` = `t`.`id`))) where (`a`.`termocomposto_id` is not null) group by `a`.`termocomposto_id`,`a`.`tag_id` order by group_concat(`t`.`token` separator ' ')

--Melhor rodar de cada anotador separadamente (Primeiro apagar estatítiscas atuais, depois popular
############ ANOTADOR 6 - CAROL ##########################
DELETE FROM termoscompostostable WHERE anotador_id = 6;

INSERT termoscompostostable (anotador_id, termocomposto_id, termocomposto_desc, tokens_id, tags_id)
select distinct 
	`a`.`anotador_id` AS `anotador_id`,
	`a`.`termocomposto_id` AS `termocomposto_id`,
	group_concat(`t`.`token` separator ' ') AS `termocomposto_desc`,
	group_concat(`t`.`id` separator ',') AS `tokens_id`,
	(
		select 
			group_concat(distinct `a2`.`tag_id` separator ',') 
		from 
			`anotacoes` `a2` 
		where 
			(`a2`.`termocomposto_id` = `a`.`termocomposto_id` AND `a2`.anotador_id = 6)
	) AS `tags_id` 
from 
	(`anotacoes` `a` 
join `tokens` `t` on((`a`.`token_id` = `t`.`id`))) 
where 
	(`a`.`termocomposto_id` is not null AND `a`.anotador_id = 6) 
group by 
	`a`.`termocomposto_id`,`a`.`tag_id` 
order by 
	group_concat(`t`.`token` separator ' ');
	
############ ANOTADOR 8 - LETICIA ##########################
DELETE FROM termoscompostostable WHERE anotador_id = 8;

INSERT termoscompostostable (anotador_id, termocomposto_id, termocomposto_desc, tokens_id, tags_id)
select distinct 
	`a`.`anotador_id` AS `anotador_id`,
	`a`.`termocomposto_id` AS `termocomposto_id`,
	group_concat(`t`.`token` separator ' ') AS `termocomposto_desc`,
	group_concat(`t`.`id` separator ',') AS `tokens_id`,
	(
		select 
			group_concat(distinct `a2`.`tag_id` separator ',') 
		from 
			`anotacoes` `a2` 
		where 
			(`a2`.`termocomposto_id` = `a`.`termocomposto_id` AND `a2`.anotador_id = 8)
	) AS `tags_id` 
from 
	(`anotacoes` `a` 
join `tokens` `t` on((`a`.`token_id` = `t`.`id`))) 
where 
	(`a`.`termocomposto_id` is not null AND `a`.anotador_id = 8) 
group by 
	`a`.`termocomposto_id`,`a`.`tag_id` 
order by 
	group_concat(`t`.`token` separator ' ');
	
############ ANOTADOR 9 - THAIZA ##########################
DELETE FROM termoscompostostable WHERE anotador_id = 9;

INSERT termoscompostostable (anotador_id, termocomposto_id, termocomposto_desc, tokens_id, tags_id)
select distinct 
	`a`.`anotador_id` AS `anotador_id`,
	`a`.`termocomposto_id` AS `termocomposto_id`,
	group_concat(`t`.`token` separator ' ') AS `termocomposto_desc`,
	group_concat(`t`.`id` separator ',') AS `tokens_id`,
	(
		select 
			group_concat(distinct `a2`.`tag_id` separator ',') 
		from 
			`anotacoes` `a2` 
		where 
			(`a2`.`termocomposto_id` = `a`.`termocomposto_id` AND `a2`.anotador_id = 9)
	) AS `tags_id` 
from 
	(`anotacoes` `a` 
join `tokens` `t` on((`a`.`token_id` = `t`.`id`))) 
where 
	(`a`.`termocomposto_id` is not null AND `a`.anotador_id = 9) 
group by 
	`a`.`termocomposto_id`,`a`.`tag_id` 
order by 
	group_concat(`t`.`token` separator ' ');
	
############ ANOTADOR 10 - DEISY ##########################
DELETE FROM termoscompostostable WHERE anotador_id = 10;

INSERT termoscompostostable (anotador_id, termocomposto_id, termocomposto_desc, tokens_id, tags_id)
select distinct 
	`a`.`anotador_id` AS `anotador_id`,
	`a`.`termocomposto_id` AS `termocomposto_id`,
	group_concat(`t`.`token` separator ' ') AS `termocomposto_desc`,
	group_concat(`t`.`id` separator ',') AS `tokens_id`,
	(
		select 
			group_concat(distinct `a2`.`tag_id` separator ',') 
		from 
			`anotacoes` `a2` 
		where 
			(`a2`.`termocomposto_id` = `a`.`termocomposto_id` AND `a2`.anotador_id = 10)
	) AS `tags_id` 
from 
	(`anotacoes` `a` 
join `tokens` `t` on((`a`.`token_id` = `t`.`id`))) 
where 
	(`a`.`termocomposto_id` is not null AND `a`.anotador_id = 10) 
group by 
	`a`.`termocomposto_id`,`a`.`tag_id` 
order by 
	group_concat(`t`.`token` separator ' ');
	
------------------------------------------

ALTER TABLE `anotacoes`
	CHANGE COLUMN `adjudicador` `adjudicador` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0=Anotação, 1=Adjudicação' AFTER `status`;
	
ALTER TABLE `relacionamentos`
	ADD COLUMN `adjudicador` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0=Anotação, 1=Adjudicação' AFTER `dataanotacao`,
	ADD INDEX `IDX_adjudicador` (`adjudicador`);