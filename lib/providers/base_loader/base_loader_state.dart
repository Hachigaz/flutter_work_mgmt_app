part of 'base_loader_bloc.dart';

class BaseLoaderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BaseLoaderStateLoading extends BaseLoaderState {}

class BaseLoaderStateReady extends BaseLoaderState {
  final StorageRepository storageRepo;

  BaseLoaderStateReady({required this.storageRepo});

  @override
  List<Object?> get props => [...super.props, storageRepo];
}
