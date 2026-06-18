/// Résultat d'une opération : soit [Success], soit [Failure]. `sealed` force le
/// traitement exhaustif des deux cas et évite les try/catch dans les ViewModels.
sealed class Result<T> {
  const Result();
}

/// Succès : porte la valeur produite.
class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

/// Échec : porte un message d'erreur affichable par l'UI.
class Failure<T> extends Result<T> {
  final String message;
  const Failure(this.message);
}
