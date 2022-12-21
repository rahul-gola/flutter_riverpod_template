mixin LayerDataTransformer<F, T> {
  T transform();

  F restore(T data);
}
