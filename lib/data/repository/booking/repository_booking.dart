import 'package:booking_hotel/data/models/auth_response/auth_response_model.dart';
import 'package:booking_hotel/data/models/booking_model.dart';
import 'package:booking_hotel/data/models/common_models/status_model.dart';
import 'package:booking_hotel/data/remote/booking/booking_data_source.dart';
import 'package:dartz/dartz.dart';

abstract class RepositoryBooking {

  late BookingDataSource bookingDataSource ;
  Future<Either<String, BookingModel>> getBooking(String token , String type , int count , int page);
  Future<Either<String, StatusModel>> createBooking(String token , int hotelId);
  Future<Either<String, StatusModel>> updateBooking(String token , int bookingId ,String type);

}