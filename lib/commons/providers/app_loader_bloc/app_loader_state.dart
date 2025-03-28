part of 'app_loader_bloc.dart';

class AppLoaderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppLoaderStateLoading extends AppLoaderState {}

class AppLoaderStateReady extends AppLoaderState {
  final StorageRepository storageRepo;

  AppLoaderStateReady({required this.storageRepo});

  @override
  List<Object?> get props => [...super.props, storageRepo];
}
