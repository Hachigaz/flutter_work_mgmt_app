typedef ListReturnResult<T> = ({bool isLast, List<T> itemList});

abstract class DataRepository<T> {
  ListReturnResult<T> search(String searchValue);
  T getOne();
}
