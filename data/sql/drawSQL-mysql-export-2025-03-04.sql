CREATE TABLE `nomads`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `rank` BIGINT NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    `overall` BIGINT NOT NULL,
    `cost` BIGINT NOT NULL,
    `internet` BIGINT NOT NULL,
    `safety` BIGINT NOT NULL,
    `country_code` VARCHAR(2) NOT NULL
);
CREATE TABLE `cost_of_living`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `city` VARCHAR(255) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    `meal` FLOAT(53) NOT NULL,
    `mcdonalds` FLOAT(53) NOT NULL,
    `beer` FLOAT(53) NOT NULL,
    `coffee` FLOAT(53) NOT NULL,
    `monthly_pass` FLOAT(53) NOT NULL,
    `monthly_rent` FLOAT(53) NOT NULL,
    `country_code` VARCHAR(2) NOT NULL
);
CREATE TABLE `quality_of_life`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `country` VARCHAR(255) NOT NULL,
    `safety_value` FLOAT(53) NOT NULL,
    `safety_category` VARCHAR(255) NOT NULL,
    `climate_value` FLOAT(53) NOT NULL,
    `climate_category` VARCHAR(255) NOT NULL,
    `cost_of_living_value` FLOAT(53) NOT NULL,
    `cost_of_living_category` VARCHAR(255) NOT NULL,
    `pollution_value` FLOAT(53) NOT NULL,
    `pollution_category` VARCHAR(255) NOT NULL,
    `quality_of_life_value` FLOAT(53) NOT NULL,
    `quality_of_life_category` VARCHAR(255) NOT NULL,
    `country_code` VARCHAR(2) NOT NULL
);
CREATE TABLE `internet_speed`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `country` VARCHAR(255) NOT NULL,
    `broadband` FLOAT(53) NOT NULL,
    `mobile` FLOAT(53) NOT NULL,
    `country_code` VARCHAR(2) NOT NULL
);
CREATE TABLE `wework_loc`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `country` VARCHAR(255) NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `latitude` FLOAT(53) NOT NULL,
    `longitude` FLOAT(53) NOT NULL,
    `country_code` VARCHAR(2) NOT NULL
);
ALTER TABLE
    `internet_speed` ADD CONSTRAINT `internet_speed_country_foreign` FOREIGN KEY(`country`) REFERENCES `nomads`(`country`);
ALTER TABLE
    `nomads` ADD CONSTRAINT `nomads_city_foreign` FOREIGN KEY(`city`) REFERENCES `cost_of_living`(`city`);
ALTER TABLE
    `wework_loc` ADD CONSTRAINT `wework_loc_city_foreign` FOREIGN KEY(`city`) REFERENCES `nomads`(`city`);
ALTER TABLE
    `quality_of_life` ADD CONSTRAINT `quality_of_life_country_foreign` FOREIGN KEY(`country`) REFERENCES `nomads`(`country`);