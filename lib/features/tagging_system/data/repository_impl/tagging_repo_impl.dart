import 'package:dartz/dartz.dart';
import 'package:myapp/features/tagging_system/data/data_source/tagging_remote_datasource.dart';
import 'package:myapp/features/tagging_system/domain/entities/tag_system.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repository/tag_repo.dart';

class TaggingRepoImpl implements TagRepository {
  final TaggingRemoteDatasource _datasource;

  const TaggingRepoImpl(this._datasource);

  @override
  Future<Either<Failure, void>> createTag(Tag tag) async {
    try {
      return Right(await _datasource.createTag(tag));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTag(String id) async {
    try {
      return Right(await _datasource.deleteTag(id));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Tag>>> getAllTags() async {
    try {
      return Right(await _datasource.getAllTags());
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tag?>> getTagById(String id) async {
    try {
      return Right(await _datasource.getTagById(id));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTag(Tag tag) async {
    try {
      return Right(await _datasource.updateTag(tag));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}