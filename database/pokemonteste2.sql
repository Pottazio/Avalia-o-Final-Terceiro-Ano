
CREATE TABLE batalha_pokemons
(
  id_batalha INT                    NOT NULL,
  id_pokemon INT                    NOT NULL,
  lado       ENUM(JOGADOR,OPONENTE) NOT NULL,
  hp_inicial INT                    NOT NULL,
  hp_final   INT                    NOT NULL,
  venceu     BOOLEAN                NULL     DEFAULT FALSE,
  PRIMARY KEY (id_batalha, id_pokemon)
);

CREATE TABLE batalhas
(
  id_batalha    INT                   NULL     AUTO_INCREMENT,
  id_perfil     INT                   NOT NULL,
  resultado     ENUM(VITORIA,DERROTA) NOT NULL,
  recompensa    INT                   NOT NULL DEFAULT 0,
  iniciada_em   DATETIME              NULL     DEFAULT CURRENT_TIMESTAMP,
  finalizada_em DATETIME              NULL    ,
  PRIMARY KEY (id_batalha)
);

CREATE TABLE log_turnos (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_batalha INT NOT NULL,
    turno INT NOT NULL,
    id_pokemon INT,
    acao VARCHAR(50) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    hp_antes INT,
    hp_depois INT,
    registrado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE categorias_itens
(
  id_categoria INT         NULL     AUTO_INCREMENT,
  nome         VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_categoria)
);

ALTER TABLE categorias_itens
  ADD CONSTRAINT UQ_categorias_itens_nome UNIQUE (nome);

CREATE TABLE compras
(
  id_compra      INT      NULL     AUTO_INCREMENT,
  id_perfil      INT      NOT NULL,
  id_item        INT      NOT NULL,
  quantidade     INT      NOT NULL,
  valor_unitario INT      NOT NULL,
  valor_total    INT      NOT NULL,
  comprado_em    DATETIME NULL     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_compra)
);

CREATE TABLE inventarios
(
  id_perfil  INT NOT NULL,
  id_item    INT NOT NULL,
  quantidade INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id_perfil, id_item)
);

CREATE TABLE itens
(
  id_item      INT          NULL     AUTO_INCREMENT,
  id_categoria INT          NOT NULL,
  nome         VARCHAR(100) NOT NULL,
  descricao    VARCHAR(255) NULL    ,
  preco        INT          NOT NULL,
  valor_hp     INT          NULL     DEFAULT 0,
  cura_status  BOOLEAN      NULL     DEFAULT FALSE,
  revive       BOOLEAN      NULL     DEFAULT FALSE,
  evolucao     BOOLEAN      NULL     DEFAULT FALSE,
  PRIMARY KEY (id_item)
);

CREATE TABLE perfis
(
  id_perfil   INT         NULL     AUTO_INCREMENT,
  id_usuario  INT         NOT NULL,
  nome_perfil VARCHAR(50) NOT NULL DEFAULT guest,
  pokedollar  INT         NOT NULL DEFAULT 0,
  PRIMARY KEY (id_perfil)
);

CREATE TABLE pokemon_tipos
(
  id_pokemon INT NOT NULL,
  id_tipo    INT NOT NULL,
  PRIMARY KEY (id_pokemon, id_tipo)
);

CREATE TABLE pokemons
(
  id_pokemon      INT          NULL     AUTO_INCREMENT,
  id_api          INT          NOT NULL,
  nome            VARCHAR(100) NOT NULL,
  nivel           INT          NOT NULL DEFAULT 1,
  hp_max          INT          NOT NULL,
  hp_atual        INT          NOT NULL,
  ataque          INT          NOT NULL,
  defesa          INT          NOT NULL,
  ataque_especial INT          NOT NULL,
  defesa_especial INT          NOT NULL,
  velocidade      INT          NOT NULL,
  prioridade      INT          NOT NULL DEFAULT 0,
  experiencia     INT          NOT NULL DEFAULT 0,
  status          VARCHAR(30)  NULL     DEFAULT NULL,
  criado_em       DATETIME     NULL     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_pokemon)
);

CREATE TABLE time_pokemons
(
  id_time    INT NOT NULL,
  id_pokemon INT NOT NULL,
  posicao    INT NOT NULL,
  PRIMARY KEY (id_time, id_pokemon)
);

CREATE TABLE times
(
  id_time   INT         NULL     AUTO_INCREMENT,
  id_perfil INT         NOT NULL,
  nome      VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_time)
);

CREATE TABLE tipos
(
  id_tipo INT         NULL     AUTO_INCREMENT,
  nome    VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_tipo)
);

ALTER TABLE tipos
  ADD CONSTRAINT UQ_tipos_nome UNIQUE (nome);

CREATE TABLE usuarios
(
  id_usuario INT          NULL     AUTO_INCREMENT,
  nome       VARCHAR(100) NOT NULL,
  email      VARCHAR(150) NOT NULL,
  senha      VARCHAR(255) NOT NULL,
  criado_em  DATETIME     NULL     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_usuario)
);

ALTER TABLE usuarios
  ADD CONSTRAINT UQ_usuarios_email UNIQUE (email);

ALTER TABLE perfis
  ADD CONSTRAINT FK_usuarios_TO_perfis
    FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id_usuario);

ALTER TABLE pokemon_tipos
  ADD CONSTRAINT FK_pokemons_TO_pokemon_tipos
    FOREIGN KEY (id_pokemon)
    REFERENCES pokemons (id_pokemon);

ALTER TABLE pokemon_tipos
  ADD CONSTRAINT FK_tipos_TO_pokemon_tipos
    FOREIGN KEY (id_tipo)
    REFERENCES tipos (id_tipo);

ALTER TABLE times
  ADD CONSTRAINT FK_perfis_TO_times
    FOREIGN KEY (id_perfil)
    REFERENCES perfis (id_perfil);

ALTER TABLE time_pokemons
  ADD CONSTRAINT FK_times_TO_time_pokemons
    FOREIGN KEY (id_time)
    REFERENCES times (id_time);

ALTER TABLE time_pokemons
  ADD CONSTRAINT FK_pokemons_TO_time_pokemons
    FOREIGN KEY (id_pokemon)
    REFERENCES pokemons (id_pokemon);

ALTER TABLE itens
  ADD CONSTRAINT FK_categorias_itens_TO_itens
    FOREIGN KEY (id_categoria)
    REFERENCES categorias_itens (id_categoria);

ALTER TABLE inventarios
  ADD CONSTRAINT FK_perfis_TO_inventarios
    FOREIGN KEY (id_perfil)
    REFERENCES perfis (id_perfil);

ALTER TABLE inventarios
  ADD CONSTRAINT FK_itens_TO_inventarios
    FOREIGN KEY (id_item)
    REFERENCES itens (id_item);

ALTER TABLE batalhas
  ADD CONSTRAINT FK_perfis_TO_batalhas
    FOREIGN KEY (id_perfil)
    REFERENCES perfis (id_perfil);

ALTER TABLE batalha_pokemons
  ADD CONSTRAINT FK_batalhas_TO_batalha_pokemons
    FOREIGN KEY (id_batalha)
    REFERENCES batalhas (id_batalha);

ALTER TABLE batalha_pokemons
  ADD CONSTRAINT FK_pokemons_TO_batalha_pokemons
    FOREIGN KEY (id_pokemon)
    REFERENCES pokemons (id_pokemon);

ALTER TABLE compras
  ADD CONSTRAINT FK_perfis_TO_compras
    FOREIGN KEY (id_perfil)
    REFERENCES perfis (id_perfil);

ALTER TABLE compras
  ADD CONSTRAINT FK_itens_TO_compras
    FOREIGN KEY (id_item)
    REFERENCES itens (id_item);