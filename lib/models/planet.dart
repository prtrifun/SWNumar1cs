class Planet {
  final String? name;
  final String? rotationPeriod;
  final String? orbitalPeriod;
  final String? diameter;
  final String? climate;
  final String? gravity;
  final String? terrain;
  final String? surfaceWater;
  final String? population;
  final List<String> residents;
  final List<String> films;
  final String? url;

  const Planet({
    this.name,
    this.rotationPeriod,
    this.orbitalPeriod,
    this.diameter,
    this.climate,
    this.gravity,
    this.terrain,
    this.surfaceWater,
    this.population,
    this.residents = const [],
    this.films = const [],
    this.url,
  });

  factory Planet.fromJson(Map<String, dynamic> data) {
    final List<String> residents = [];
    if (data['residents'] != null) {
      for (String resident in data['residents']) {
        residents.add(resident);
      }
    }

    final List<String> films = [];
    if (data['films'] != null) {
      for (String film in data['films']) {
        films.add(film);
      }
    }

    return Planet(
      name: data['name'],
      rotationPeriod: data['rotation_period'],
      orbitalPeriod: data['orbital_period'],
      diameter: data['diameter'],
      climate: data['climate'],
      gravity: data['gravity'],
      terrain: data['terrain'],
      surfaceWater: data['surface_water'],
      population: data['population'],
      residents: residents,
      films: films,
      url: data['url'],
    );
  }
}
