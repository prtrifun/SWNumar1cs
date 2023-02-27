import 'package:flutter/material.dart';
import 'package:swnumar1cs/models/film.dart';
import 'package:swnumar1cs/models/person.dart';

class Vehicle {
  final String? name;
  final String? model;
  final String? manufacturer;
  final String? costInCredits;
  final String? length;
  final String? maxAtmospheringSpeed;
  final String? crew;
  final String? passengers;
  final String? cargoCapacity;
  final String? consumables;
  @protected
  final String? vehicleClass;
  final List<Person>? pilots;
  final List<Film>? films;
  final String? url;

  const Vehicle({
    this.name,
    this.model,
    this.manufacturer,
    this.costInCredits,
    this.length,
    this.maxAtmospheringSpeed,
    this.crew,
    this.passengers,
    this.cargoCapacity,
    this.consumables,
    this.vehicleClass,
    this.pilots,
    this.films,
    this.url,
  });

  factory Vehicle.fromJson(Map<String, dynamic> data) {
    return Vehicle(
      name: data['name'],
      model: data['model'],
      manufacturer: data['manufacturer'],
      costInCredits: data['cost_in_credits'],
      length: data['length'],
      maxAtmospheringSpeed: data['max_atmosphering_speed'],
      crew: data['crew'],
      passengers: data['passengers'],
      cargoCapacity: data['cargo_capacity'],
      consumables: data['consumables'],
      vehicleClass: data['vehicle_class'],
      url: data['url'],
    );
  }
}
