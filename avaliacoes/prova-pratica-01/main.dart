// Feito por: Kelwin Jhackson Gonçalves de Moura
// 18/12/2024 - 13h30min

import 'dart:async';
import 'package:sqlite3/sqlite3.dart';

// Classe para gerenciar o banco de dados SQLite
class DatabaseHelper {
  late Database db;

  // Inicializa o banco de dados e cria a tabela se não existir
  Future<void> initializeDB() async {
    db = sqlite3.open('alunos.db'); // Banco de dados em um arquivo local
    db.execute('''
      CREATE TABLE IF NOT EXISTS TB_ALUNOS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        idade INTEGER NOT NULL
      )
    ''');
  }

  // Fecha o banco de dados
  void closeDB() {
    db.dispose();
  }

  Future<void> dropTable() async {
    final stmt = db.prepare('DROP TABLE TB_ALUNOS');
    stmt.execute([]);
    stmt.dispose();
    print('\nTabela deletada com sucesso!');
  }

  // Insere um novo aluno na tabela
  Future<void> insertAluno(Alunos aluno) async {
    final stmt =
        db.prepare('INSERT INTO TB_ALUNOS (nome, idade) VALUES (?, ?)');
    stmt.execute([aluno.nome, aluno.idade]);
    stmt.dispose();
  }

  // Consulta todos os alunos da tabela
  Future<List<Alunos>> getAlunos() async {
    final result = db.select('SELECT * FROM TB_ALUNOS');
    return result.map((row) => Alunos.fromMap(row)).toList();
  }

  // Atualiza os dados de um aluno pelo ID
  Future<void> updateAluno(Alunos aluno) async {
    final stmt =
        db.prepare('UPDATE TB_ALUNOS SET nome = ?, idade = ? WHERE id = ?');
    stmt.execute([aluno.nome, aluno.idade, aluno.id]);
    stmt.dispose();
  }

  // Deleta um aluno pelo ID
  Future<void> deleteAluno(int id) async {
    final stmt = db.prepare('DELETE FROM TB_ALUNOS WHERE id = ?');
    stmt.execute([id]);
    stmt.dispose();
  }
}

// Classe Alunos
class Alunos {
  int? id;
  String nome;
  int idade;

  Alunos({this.id, required this.nome, required this.idade});

  // Converte um objeto Alunos para um mapa (para inserir no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
    };
  }

  // Cria um objeto Alunos a partir de um mapa (retorno do banco)
  factory Alunos.fromMap(Map<String, dynamic> map) {
    return Alunos(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
    );
  }
}

// Função principal para testar as operações CRUD
void main() async {
  final dbHelper = DatabaseHelper();
  await dbHelper.initializeDB();

  // Inserindo novos alunos
  print('Inserindo alunos...');
  final aluno1 = Alunos(nome: 'Kelwin', idade: 18);
  final aluno2 = Alunos(nome: 'Leonardo', idade: 17);
  final aluno3 = Alunos(nome: 'Arpuro', idade: 17);
  final aluno4 = Alunos(nome: 'Lucas', idade: 17);
  final aluno5 = Alunos(nome: 'Aguinha', idade: 17);
  final aluno6 = Alunos(nome: 'Jenas', idade: 16);

  await dbHelper.insertAluno(aluno1);
  await dbHelper.insertAluno(aluno2);
  await dbHelper.insertAluno(aluno3);
  await dbHelper.insertAluno(aluno4);
  await dbHelper.insertAluno(aluno5);
  await dbHelper.insertAluno(aluno6);

  // Consultando alunos
  print('\nConsultando alunos:');
  List<Alunos> alunos = await dbHelper.getAlunos();
  for (var aluno in alunos) {
    print('ID: ${aluno.id}, Nome: ${aluno.nome}, Idade: ${aluno.idade}');
  }

  // Atualizando um aluno
  print('\nAtualizando aluno com ID 1...');
  final alunoAtualizado1 = Alunos(id: 1, nome: 'Kelwin Jhackson', idade: 19);
  await dbHelper.updateAluno(alunoAtualizado1);

  print('\nAtualizando aluno com ID 2...');
  final alunoAtualizado2 = Alunos(id: 2, nome: 'Leandro Silva', idade: 22);
  await dbHelper.updateAluno(alunoAtualizado2);

  print('\nAtualizando aluno com ID 3...');
  final alunoAtualizado3 = Alunos(id: 3, nome: 'Arpuro Belmino', idade: 13);
  await dbHelper.updateAluno(alunoAtualizado3);

  print('\nAtualizando aluno com ID 4...');
  final alunoAtualizado4 = Alunos(id: 4, nome: 'Lucas Gonzadaga', idade: 13);
  await dbHelper.updateAluno(alunoAtualizado4);

  print('\nAtualizando aluno com ID 5...');
  final alunoAtualizado5 = Alunos(id: 5, nome: 'Aguinha Filho', idade: 23);
  await dbHelper.updateAluno(alunoAtualizado5);

  print('\nAtualizando aluno com ID 6...');
  final alunoAtualizado6 =
      Alunos(id: 6, nome: 'Jenas Not From de Apple', idade: 32);
  await dbHelper.updateAluno(alunoAtualizado6);

  // Consultando novamente
  print('\nConsultando após atualização:');
  alunos = await dbHelper.getAlunos();
  for (var aluno in alunos) {
    print('ID: ${aluno.id}, Nome: ${aluno.nome}, Idade: ${aluno.idade}');
  }

  // Deletando um aluno
  print('\nDeletando aluno com ID 1...');
  await dbHelper.deleteAluno(1);

  // Consultando após deletar
  print('\nConsultando após exclusão:');
  alunos = await dbHelper.getAlunos();
  for (var aluno in alunos) {
    print('ID: ${aluno.id}, Nome: ${aluno.nome}, Idade: ${aluno.idade}');
  }

  print('\nDeletando a tabela inteira (pra varios testes)...');
  await dbHelper.dropTable();
  dbHelper.closeDB();
}
