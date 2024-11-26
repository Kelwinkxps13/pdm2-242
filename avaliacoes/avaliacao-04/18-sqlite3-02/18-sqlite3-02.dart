//
//

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Aluno {
  int id;
  String nome;
  String dataNascimento;

  Aluno({required this.id, required this.nome, required this.dataNascimento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data_nascimento': dataNascimento,
    };
  }
}

class AlunoDatabase {
  static final AlunoDatabase instance = AlunoDatabase._init();

  static Database? _database;

  AlunoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return database;

    _database = await _initDB('aluno.db');
    return database;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TB_ALUNOS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        data_nascimento TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertAluno(Aluno aluno) async {
    final db = await database;
    return await db.insert('TB_ALUNOS', aluno.toMap());
  }

  Future<Aluno> getAluno(int id) async {
    final db = await database;
    final maps = await db.query(
      'TB_ALUNOS',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Aluno(
      id: maps.first['id'],
      nome: maps.first['nome'],
      dataNascimento: maps.first['data_nascimento'],
    );
  }

  Future<List<Aluno>> getAllAlunos() async {
    final db = await database;
    final maps = await db.query('TB_ALUNOS');

    return List.generate(maps.length, (i) {
      return Aluno(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        dataNascimento: maps[i]['data_nascimento'],
      );
    });
  }

  Future<int> updateAluno(Aluno aluno) async {
    final db = await database;
    return await db.update(
      'TB_ALUNOS',
      aluno.toMap(),
      where: 'id = ?',
      whereArgs: [aluno.id],
    );
  }

  Future<int> deleteAluno(int id) async {
    final db = await database;
    return await db.delete(
      'TB_ALUNOS',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

void main() async {
  // Inicializar o banco de dados
  final db = AlunoDatabase.instance;

  // Inserir um aluno
  final aluno1 =
      (Aluno(id: 1, nome: 'Kelwin Jhackson', dataNascimento: '03/08/2006'));
  final aluno2 =
      (Aluno(id: 2, nome: 'Lucas Costa', dataNascimento: '01/12/2007'));
  final aluno3 =
      (Aluno(id: 3, nome: 'Vinicius Mango', dataNascimento: '14/06/2007'));
  int aluno1x = await db.insertAluno(aluno1);
  int aluno2x = await db.insertAluno(aluno2);
  int aluno3x = await db.insertAluno(aluno3);

  // Buscar um aluno pelo ID
  Aluno retrievedAluno1 = await db.getAluno(aluno1x);
  Aluno retrievedAluno2 = await db.getAluno(aluno2x);
  Aluno retrievedAluno3 = await db.getAluno(aluno3x);
  print('Aluno recuperado: $retrievedAluno1');
  print('Aluno recuperado: $retrievedAluno2');
  print('Aluno recuperado: $retrievedAluno3');

  // Atualizar os dados de um aluno
  retrievedAluno1.nome = 'Kelwin Jhackson';
  retrievedAluno2.nome = 'Lucas Costa';
  retrievedAluno3.nome = 'Vinicius Mango';
  await db.updateAluno(retrievedAluno1);
  await db.updateAluno(retrievedAluno2);
  await db.updateAluno(retrievedAluno3);

  // Buscar todos os alunos
  List<Aluno> alunos = await db.getAllAlunos();
  print('Todos os alunos: $alunos');

  // Deletar um aluno
  await db.deleteAluno(aluno1x);
  await db.deleteAluno(aluno2x);
  await db.deleteAluno(aluno3x);
}
