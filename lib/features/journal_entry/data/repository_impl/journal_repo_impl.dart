import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/repository/journal_repo.dart';
import '../data_source/journal_remote_datasource.dart';


class JournalRepoImpl implements JournalRepository {
  final JournalRemoteDatasource _datasource;

  const JournalRepoImpl(this._datasource);

  @override
  Future<Either<Failure, void>> createJournalEntry(JournalEntry entry) async {
    try {
      return Right(await _datasource.createJournalEntry(entry));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteJournalEntry(String id) async {
    try {
      return Right(await _datasource.deleteJournalEntry(id));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<JournalEntry>>> getAllJournalEntries() async {
    try {
      return Right(await _datasource.getAllJournalEntries());
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, JournalEntry?>> getJournalEntryById(String id) async {
    try {
      return Right(await _datasource.getJournalEntryById(id));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateJournalEntry(JournalEntry entry) async {
    try {
      return Right(await _datasource.updateJournalEntry(entry));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}