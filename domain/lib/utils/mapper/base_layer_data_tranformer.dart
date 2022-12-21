import 'layer_data_transformer.dart';

abstract class BaseLayerDataTransformer<F, T>
    implements LayerDataTransformer<F, T> {
  @override
  F restore(T data);

  @override
  T transform();
}
