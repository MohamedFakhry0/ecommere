import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_c10_frida/data/api_manager/api_manager.dart';
import 'package:ecommerce_app_c10_frida/data/datasource_contract/auth_datasource.dart';
import 'package:ecommerce_app_c10_frida/data/model/auth_response/AuthResponse.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AuthDataSource)
class AuthDataSourceImpl extends AuthDataSource{
  ApiManager apiManager;
  @factoryMethod
  AuthDataSourceImpl({required this.apiManager});
  @override
  Future<Either<AuthResponse, String>> signUp({required String email, required String password, required String mobileNumber, required String name})async {
   try{
     var response = await apiManager.register(name: name, email: email, mobileNumber: mobileNumber, password: password);
     if(response.statusMsg != null){
       return Right(response.message ?? '');
     }else{
       return Left(response);
     }
   }catch(e){
     return Right(e.toString());
   }
  }

  @override
  Future<Either<AuthResponse, String>> signIn({required String email, required String password})async {

    try{
      var response = await apiManager.login(email: email, password: password);

      if(response.statusMsg != null){
        return Right(response.message ?? '');
      }else{
        return Left(response);
      }
    }catch(e){
      return Right(e.toString());
    }

  }

}