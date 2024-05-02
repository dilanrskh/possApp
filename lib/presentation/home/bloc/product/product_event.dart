part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  // ini untuk fetch / ambil data dari api
  const factory ProductEvent.fetch() = _Fetch;
  // ini untuk ambil data dari api dan di filter berdasarkan kategori
  const factory ProductEvent.fetchByCategory(String category) = _FetchByCategory;
}