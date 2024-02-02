import 'package:equatable/equatable.dart';

///This is the entity for a particular publisher.
class Publisher extends Equatable {
  const Publisher({
    required this.id,
    required this.publisherName,
    this.publisherProfileImageURL,
  });

  //The user id of the publisher
  final String id;
  //Author/Publisher name
  final String publisherName;
  //Profile image for publisher
  final String? publisherProfileImageURL;

  @override
  List<Object?> get props => [id];
}
