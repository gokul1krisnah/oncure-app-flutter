import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/model/error/failure.dart';
import '../../../../../core/model/response/response_model.dart';
import '../model/blog/blog_model.dart';
import '../model/doctor/doctor_model.dart';
import '../sources/rds/home_rds.dart';

@injectable
class HomeRepository {
  final HomeRds _homeRds;
  HomeRepository(this._homeRds);

  // ignore: prefer_expression_function_bodies
  Future<Either<Failure, ResponseModel<GetHomeResponse>>> getHome() async {
    // return _homeRds.getHome();
    return right(
      ResponseModel(
        data: const GetHomeResponse(
          doctors: [
            DoctorModel(name: 'Dr.Guptha', specialization: 'Oncologist'),
            DoctorModel(name: 'Dr.Guptha', specialization: 'Oncologist'),
            DoctorModel(name: 'Dr.Guptha', specialization: 'Oncologist'),
           
          ],
          blogs: [
            BlogModel(
              title: 'title',
              body: 'body',
              description: 'description',
              date: 'date',
              tags: 'tags',
              category: 'category',
            ),
            BlogModel(
              title: 'title2',
              body: 'body2',
              description: 'description2',
              date: 'date2',
              tags: 'tags2',
              category: 'category2',
            ),
          ],
        ),
      ),
    );
  }
}
