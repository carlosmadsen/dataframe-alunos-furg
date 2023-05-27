library(farff)

rm(list = ls())

#url onde estão dos arquivos csv dos dados abertos 
url <- 'https://sistemas.furg.br/sistemas/dados_abertos/arquivos/';

#carregando os dataframes
df_alunos <- read.csv(paste(url,'siagrad-aluno.csv', sep = ""));
df_cursos <- read.csv(paste(url,'siagrad-curso.csv', sep = ""));
df_ciclos_letivos <- read.csv(paste(url,'siagrad-ciclo-letivo.csv', sep = ""));
df_modo_ingresso <- read.csv(paste(url,'siagrad-modo-ingresso.csv', sep = ""));
df_alunos_afastamentos <- read.csv(paste(url,'siagrad-aluno-afastamento.csv', sep = ""));
df_tipos_afastamentos <- read.csv(paste(url,'siagrad-tipo-afastamento.csv', sep = ""));
df_areas_conhecimentos <- read.csv(paste(url,'siagrad-area-conhecimento.csv', sep = ""));
df_niveis_ensino <- read.csv(paste(url,'siagrad-nivel-ensino.csv', sep = ""));
df_curso_presenca <- read.csv(paste(url,'siagrad-curso-presenca.csv', sep = ""));
remove(url)

#convertendo informações para o dataframe de aluno 

#atributo com o nome do curso  
ids_cursos <- df_cursos$id_curso 
nm_cursos <- df_cursos$nm_curso 
names(nm_cursos) <- ids_cursos 
df_alunos$curso <- nm_cursos[as.character(df_alunos$id_curso)]
remove(nm_cursos)

#área de conhecimento do curso 
ids_areas <- df_areas_conhecimentos$id_area_conhecimento
nm_areas <- df_areas_conhecimentos$ds_area_conhecimento
names(nm_areas) <- ids_areas
df_cursos$area_conhecimento_curso <- nm_areas[as.character(df_cursos$id_area_conhecimento)]
nm_areas_cursos <- df_cursos$area_conhecimento_curso
names(nm_areas_cursos) <- ids_cursos 
df_alunos$area_conhecimento_curso <- nm_areas_cursos[as.character(df_alunos$id_curso)]
remove(ids_areas)
remove(nm_areas)
remove(df_areas_conhecimentos)
remove(nm_areas_cursos)

#niveis de ensino do curso 
ids_niveis <- df_niveis_ensino$id_nivel_ensino
nm_niveis <- df_niveis_ensino$ds_nivel_ensino_agrupado
names(nm_niveis) <- ids_niveis
df_cursos$nivel_ensino_curso <- nm_niveis[as.character(df_cursos$id_nivel_ensino)]
nm_niveis_cursos <- df_cursos$nivel_ensino_curso
names(nm_niveis_cursos) <- ids_cursos 
df_alunos$nivel_ensino_curso <- nm_niveis_cursos[as.character(df_alunos$id_curso)]
remove(nm_niveis)
remove(nm_niveis_cursos)
remove(ids_niveis)

#tipos de graduações dos cursos
ids_niveis_graduacoes <- df_niveis_ensino$id_nivel_ensino[df_niveis_ensino$ds_nivel_ensino_agrupado == 'Graduação']
nm_graduacoes <- df_niveis_ensino$ds_nivel_ensino_v2[df_niveis_ensino$ds_nivel_ensino_agrupado == 'Graduação']
names(nm_graduacoes) <- ids_niveis_graduacoes
df_cursos$tipo_de_graduacao <- nm_graduacoes[as.character(df_cursos$id_nivel_ensino)]
nm_graduacoes_cursos <- df_cursos$tipo_de_graduacao
names(nm_graduacoes_cursos) <- ids_cursos 
df_alunos$tipo_de_graduacao_curso <- nm_graduacoes_cursos[as.character(df_alunos$id_curso)]
remove (df_niveis_ensino)
remove(nm_graduacoes)
remove(nm_graduacoes_cursos)
remove(ids_niveis_graduacoes)

#tipo de presença do curso 
ids_presencas <- df_curso_presenca$id_curso_presenca
ds_presencas <- df_curso_presenca$ds_curso_presenca
names(ds_presencas) <- ids_presencas
df_cursos$tipo_presenca <- ds_presencas[as.character(df_cursos$id_curso_presenca)]
ds_presencas_cursos <- df_cursos$tipo_presenca
names(ds_presencas_cursos) <- ids_cursos 
df_alunos$tipo_presenca_curso <- ds_presencas_cursos[as.character(df_alunos$id_curso)]
remove(ids_presencas)
remove(ds_presencas)
remove(ds_presencas_cursos)
remove(df_curso_presenca)
remove(ids_cursos)
remove(df_cursos)

#ano de ingresso 
ids_ciclos <- df_ciclos_letivos$id_ciclo_letivo
anos_ciclos <- df_ciclos_letivos$nr_ano
names(anos_ciclos) <- ids_ciclos 
df_alunos$ano_de_ingresso <- anos_ciclos[as.character(df_alunos$id_ciclo_letivo_ingresso)]
df_alunos$id_ciclo_letivo_ingresso <- NULL 
remove(df_ciclos_letivos)
remove(anos_ciclos)
remove(ids_ciclos) 

#modo de ingresso 
ids_mi  <- df_modo_ingresso$id_modo_ingresso
ds_mi <- df_modo_ingresso$ds_modo_ingresso
names(ds_mi) <- ids_mi 
df_alunos$modo_de_ingresso <- ds_mi[as.character(df_alunos$id_modo_ingresso)]
df_alunos$id_modo_ingresso <- NULL 
remove(ds_mi)
remove(ids_mi)
remove(df_modo_ingresso)

#tipo de afastamento cirando id 
ids_alunos_afastamentos <- df_alunos_afastamentos$id_aluno
ids_tipos_afastamentos <- df_alunos_afastamentos$id_tipo_afastamento
names(ids_tipos_afastamentos) <- ids_alunos_afastamentos 
df_alunos$id_tipo_afastamento <- ids_tipos_afastamentos[as.character(df_alunos$id_aluno)]
remove(ids_alunos_afastamentos)

#tipo de afastamento: afastamento definitivo descrição
ids_tipos_afastamentos <- df_tipos_afastamentos[df_tipos_afastamentos$fl_temporario == 0, 'id_tipo_afastamento']
ds_tipos_afastamentos <- df_tipos_afastamentos[df_tipos_afastamentos$fl_temporario == 0, 'ds_tipo_afastamento']
names(ds_tipos_afastamentos) <- ids_tipos_afastamentos 
df_alunos$afastamento_definitivo <- ds_tipos_afastamentos[as.character(df_alunos$id_tipo_afastamento)]
remove(df_tipos_afastamentos)
remove(df_alunos_afastamentos)  
remove(ids_tipos_afastamentos)
remove(ds_tipos_afastamentos)
df_alunos$id_tipo_afastamento <- NULL

#removendo atributos de alunos
df_alunos$curso_anterior <- NULL 
df_alunos$id_qsl <- NULL
df_alunos$id_curso <- NULL


#arrumando tipos de dados 
df_alunos$curso <- as.factor(df_alunos$curso)
df_alunos$area_conhecimento_curso <- as.factor(df_alunos$area_conhecimento_curso)
df_alunos$nivel_ensino_curso <- as.factor(df_alunos$nivel_ensino_curso)
df_alunos$tipo_de_graduacao_curso <- as.factor(df_alunos$tipo_de_graduacao_curso)
df_alunos$tipo_presenca_curso <- as.factor(df_alunos$tipo_presenca_curso)
df_alunos$modo_de_ingresso <- as.factor(df_alunos$modo_de_ingresso)
df_alunos$afastamento_definitivo <- as.factor(df_alunos$afastamento_definitivo)


#escrevendo arquivo arff
writeARFF(df_alunos, "./alunos_furg.arff")
remove(df_alunos)

print(paste("Arquivo gerado na pasta: ", getwd()));

