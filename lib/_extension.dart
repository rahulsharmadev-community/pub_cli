extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> operator +(Map<K, V> map) {
    var temp = this;
    temp.addAll(map);
    return temp;
  }
}
