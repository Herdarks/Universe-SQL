psql --username=freecodecamp --dbname=postgres
CREATE DATABASE universe;
\c universe;
CREATE TABLE galaxy_type (
  galaxy_type_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  description TEXT NOT NULL,
  typical_age_in_millions_of_years INT NOT NULL,
  has_supermassive_black_hole BOOLEAN NOT NULL
);

INSERT INTO galaxy_type (name, description, typical_age_in_millions_of_years, has_supermassive_black_hole)
VALUES 
('Spiral', 'A galaxy in which the stars and gas clouds are concentrated mainly in one or more spiral arms.', 10000, TRUE),
('Elliptical', 'A type of galaxy having an approximately ellipsoidal shape and a smooth, nearly featureless brightness profile.', 12000, TRUE),
('Irregular', 'A galaxy that does not have a distinct regular shape, unlike a spiral or an elliptical galaxy.', 9000, FALSE);

CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  description TEXT,
  has_life BOOLEAN NOT NULL,
  age_in_millions_of_years INT NOT NULL,
  distance_from_earth INT NOT NULL
);

INSERT INTO galaxy (name, description, has_life, age_in_millions_of_years, distance_from_earth)
VALUES 
('Milky Way', 'Our home galaxy', TRUE, 13600, 0),
('Andromeda', 'Closest large galaxy', FALSE, 10000, 2500000),
('Triangulum', 'Third-largest in Local Group', FALSE, 10000, 3000000),
('Sombrero', 'Brightest galaxy in Virgo Cluster', FALSE, 10000, 29000000),
('Whirlpool', 'Face-on spiral galaxy', FALSE, 10000, 23000000),
('Black Eye', 'Galaxy with a dark band of absorbing dust', FALSE, 10000, 17000000);

CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL,
  type VARCHAR(255) NOT NULL,
  age_in_millions_of_years INT NOT NULL,
  is_spherical BOOLEAN NOT NULL,
  mass NUMERIC NOT NULL,
  radius NUMERIC NOT NULL
);

INSERT INTO star (name, galaxy_id, type, age_in_millions_of_years, is_spherical, mass, radius)
VALUES
('Sun', 1, 'G-Type Main-Sequence', 4500, TRUE, 1.0, 695700),
('Betelgeuse', 2, 'Red Supergiant', 10000, TRUE, 20.0, 887000),
('Rigel', 2, 'Blue Supergiant', 8000, TRUE, 21.0, 787500),
('Vega', 1, 'Main-Sequence', 455, TRUE, 2.0, 487500),
('Antares', 3, 'Red Supergiant', 12000, TRUE, 12.0, 722500),
('Sirius', 4, 'Main-Sequence', 250, TRUE, 2.0, 607500);

CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  star_id INT REFERENCES star(star_id) NOT NULL,
  has_life BOOLEAN,
  distance_from_earth INT NOT NULL,
  type VARCHAR(255) NOT NULL,
  radius NUMERIC NOT NULL,
  mass NUMERIC NOT NULL
);

INSERT INTO planet (name, star_id, has_life, distance_from_earth, type, radius, mass)
VALUES
('Earth', 1, TRUE, 0, 'Terrestrial', 6371, 5.972),
('Mars', 1, FALSE, 225, 'Terrestrial', 3390, 0.642),
('Jupiter', 1, FALSE, 778, 'Gas Giant', 69911, 1898.60),
('Saturn', 1, FALSE, 1427, 'Gas Giant', 58232, 568.46),
('Kepler-22b', 2, NULL, 620, 'Exoplanet', 24600, 52.250),
('Proxima Centauri b', 2, NULL, 4, 'Exoplanet', 7160, 3.250),
('Gliese 667 Cc', 3, NULL, 23, 'Exoplanet', 8340, 3.650),
('Kepler-452b', 3, NULL, 1400, 'Exoplanet', 14520, 45.250),
('HD 189733 b', 4, FALSE, 63, 'Exoplanet', 12140, 33.250),
('HD 209458 b', 4, FALSE, 153, 'Exoplanet', 14430, 29.850),
('WASP-12b', 5, FALSE, 870, 'Exoplanet', 18140, 112.250),
('WASP-17b', 5, FALSE, 1000, 'Exoplanet', 15920, 72.250);

CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  planet_id INT REFERENCES planet(planet_id) NOT NULL,
  has_life BOOLEAN NOT NULL,
  description TEXT NOT NULL,
  orbit_period INT NOT NULL,
  radius NUMERIC NOT NULL
);

INSERT INTO moon (name, planet_id, has_life, description, orbit_period, radius)
VALUES
('Moon', 1, FALSE, 'The Moon is Earths only natural satellite.', 27, 1737),
('Phobos', 2, FALSE, 'Phobos is the larger and closer of the two natural satellites of Mars.', 1, 11),
('Deimos', 2, FALSE, 'Deimos is the smaller and outermost of the two natural satellites of Mars.', 2, 6),
('Europa', 3, FALSE, 'Europa is the smallest of the four Galilean moons orbiting Jupiter.', 3, 1560),
('Ganymede', 3, FALSE, 'Ganymede is the largest moon of Jupiter and in the Solar System.', 7, 2634),
('Titan', 4, FALSE, 'Titan is the largest moon of Saturn and the second-largest natural satellite in the Solar System.', 16, 2575),
('Enceladus', 4, FALSE, 'Enceladus is the sixth-largest moon of Saturn.', 2, 252),
('Triton', 5, FALSE, 'Triton is the largest natural satellite of Neptune.', 6, 1353),
('Charon', 5, FALSE, 'Charon is the largest of the five known moons of the dwarf planet Pluto.', 6, 606),
('Nix', 5, FALSE, 'Nix is a natural satellite of Pluto.', 25, 23),
('Styx', 6, FALSE, 'Styx is a natural satellite of Pluto.', 20, 10),
('Kerberos', 6, FALSE, 'Kerberos is a natural satellite of Pluto.', 32, 12),
('Hydra', 6, FALSE, 'Hydra is a natural satellite of Pluto.', 38, 30),
('Miranda', 6, FALSE, 'Miranda is the smallest and innermost of Uranus five round satellites.', 1, 236),
('Ariel', 6, FALSE, 'Ariel is the fourth-largest of Uranus 27 known moons.', 3, 578),
('Umbriel', 6, FALSE, 'Umbriel is the third-largest and most massive of Uranus moons.', 4, 584),
('Titania', 6, FALSE, 'Titania is the largest of the moons of Uranus and the eighth-largest moon in the Solar System.', 9, 789),
('Oberon', 6, FALSE, 'Oberon is the outermost major moon of Uranus.', 13, 761),
('Io', 3, FALSE, 'Io is the innermost of the four Galilean moons of the planet Jupiter.', 2, 1821),
('Callisto', 3, FALSE, 'Callisto is the second-largest moon of Jupiter, after Ganymede.', 17, 2410);

