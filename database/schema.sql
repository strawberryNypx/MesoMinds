CREATE DATABASE IF NOT EXISTS mesominds;
USE mesominds;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('professor','aluno') NOT NULL,
    escola VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS disciplinas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    cargo VARCHAR(100) DEFAULT 'Administrador',
    ativo BOOLEAN DEFAULT TRUE,
);

CREATE TABLE IF NOT EXISTS conteudos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    id_disciplina INT NOT NULL,  
    links JSON,              
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id)
);

    CREATE TABLE IF NOT EXISTS questoes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        enunciado TEXT NOT NULL,
        id_conteudo INT,
        nivel_dificuldade ENUM('1', '2', '3') NOT NULL,
        correcao TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (id_conteudo) REFERENCES conteudos (id)
    );

CREATE TABLE IF NOT EXISTS alternativas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_questao INT NOT NULL,
    texto TEXT NOT NULL,
    correta BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_questao) REFERENCES questoes(id)
);

CREATE TABLE IF NOT EXISTS simulados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS simulado_questao (
    id_simulado INT NOT NULL,
    id_questao INT NOT NULL,
    FOREIGN KEY (id_simulado) REFERENCES simulados(id),
    FOREIGN KEY (id_questao) REFERENCES questoes(id)
);

CREATE TABLE IF NOT EXISTS turmas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS turma_usuario (
    id_turma INT NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_turma, id_usuario),
    FOREIGN KEY (id_turma) REFERENCES turmas(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

INSERT IGNORE INTO disciplinas (nome, descricao) VALUES 
('Geometria Plana', 'Estudo de figuras geométricas em duas dimensões'),
('Estatística', 'Coleta, organização e interpretação de dados'),
('Função Afim', 'Funções de primeiro grau e suas aplicações'),
('Função Quadrática', 'Funções de segundo grau e suas propriedades'),
('Função Exponencial', 'Funções exponenciais e crescimento'),
('Função Logarítmica', 'Funções logarítmicas e suas aplicações'),
('Educação Financeira', 'Matemática aplicada às finanças pessoais'),
('Análise Combinatória', 'Técnicas de contagem e agrupamentos'),
('Probabilidade', 'Cálculo de chances e eventos aleatórios'),
('Trigonometria', 'Relações trigonométricas e suas aplicações'),
('Geometria Espacial', 'Estudo de figuras tridimensionais'),
('Sistemas Lineares', 'Sistemas de equações lineares');
