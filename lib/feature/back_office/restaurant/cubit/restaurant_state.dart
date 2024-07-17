// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:core/base/cubit/base_cubit.dart';

class RestaurantState extends BaseState {
  const RestaurantState({
    required this.states,
    required this.restaurantName,
    required this.remoteAccount,
    required this.city,
    required this.stateName,
    required this.zipCode,
    required this.phone1,
    required this.phone2,
    required this.fax,
    required this.email,
    required this.website,
    required this.image,
    required this.address,
    required this.message1,
    required this.message2,
    required this.message3,
    required this.message4,
  });

  factory RestaurantState.initial() {
    return const RestaurantState(
      states: RestaurantStates.initial,
      restaurantName: 'FALCON DINNER',
      remoteAccount: '',
      city: '',
      stateName: '',
      zipCode: '',
      phone1: '',
      phone2: '',
      fax: '',
      email: '',
      website: '',
      image: null,
      address: '',
      message1: '',
      message2: '',
      message3: '',
      message4: '',
    );
  }
  final RestaurantStates? states;
  final String? restaurantName;
  final String? remoteAccount;
  final String? city;
  final String? stateName;
  final String? zipCode;
  final String? phone1;
  final String? phone2;
  final String? fax;
  final String? email;
  final String? website;
  final String? address;
  final String? message1;
  final String? message2;
  final String? message3;
  final String? message4;
  final File? image;

  @override
  List<Object?> get props => [
        states,
        restaurantName,
        remoteAccount,
        city,
        stateName,
        zipCode,
        phone1,
        phone2,
        fax,
        email,
        website,
        image,
        address,
        message1,
        message2,
        message3,
        message4,
      ];

  RestaurantState copyWith({
    RestaurantStates? states,
    String? restaurantName,
    String? remoteAccount,
    String? city,
    String? stateName,
    String? zipCode,
    String? phone1,
    String? phone2,
    String? fax,
    String? email,
    String? website,
    String? address,
    String? message1,
    String? message2,
    String? message3,
    String? message4,
    File? image,
  }) {
    return RestaurantState(
      states: states ?? this.states,
      restaurantName: restaurantName ?? this.restaurantName,
      remoteAccount: remoteAccount ?? this.remoteAccount,
      city: city ?? this.city,
      stateName: stateName ?? this.stateName,
      zipCode: zipCode ?? this.zipCode,
      phone1: phone1 ?? this.phone1,
      phone2: phone2 ?? this.phone2,
      fax: fax ?? this.fax,
      email: email ?? this.email,
      website: website ?? this.website,
      address: address ?? this.address,
      message1: message1 ?? this.message1,
      message2: message2 ?? this.message2,
      message3: message3 ?? this.message3,
      message4: message4 ?? this.message4,
      image: image ?? this.image,
    );
  }
}

enum RestaurantStates { initial, loading, completed, error }
