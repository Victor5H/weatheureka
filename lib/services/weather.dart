
import 'package:weatheureka/utilities/constants.dart';
import 'networking.dart';
import 'package:weatheureka/services/location.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherUrl?q=$cityName&appid=$weatherAPIKey&units=metric';
    var weatherData = await NetworkHelper(url: url).getDecodedData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    LocationHelper location = LocationHelper();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            "$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$weatherAPIKey&units=metric");
    var weatherData = await networkHelper.getDecodedData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
