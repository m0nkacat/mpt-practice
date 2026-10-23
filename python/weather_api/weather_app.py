import os
import requests

API_KEY = os.getenv("OPENWEATHER_API_KEY", "")


def get_weather(city="Moscow", units="metric", lang="ru"):
    url = "https://api.openweathermap.org/data/2.5/weather"
    params = {
        "q": city,
        "appid": API_KEY,
        "units": units,
        "lang": lang,
    }

    try:
        response = requests.get(url, params=params, timeout=5)


        if response.status_code == 401:
            print("Ошибка 401: неверный или неактивный API-ключ")
            return None
        if response.status_code == 404:
            print(f"Ошибка 404: город '{city}' не найден")
            return None

        response.raise_for_status()
        data = response.json()

        weather = {
            "city": data["name"],
            "temperature": data["main"]["temp"],
            "description": data["weather"][0]["description"],
            "humidity": data["main"]["humidity"],
            "wind": data["wind"]["speed"],
        }
        return weather

    except requests.exceptions.Timeout:
        print("Ошибка: превышено время ожидания (таймаут 5 сек)")
        return None
    except requests.exceptions.RequestException as e:
        print(f"Ошибка сети: {e}")
        return None
    except (KeyError, ValueError) as e:
        print(f"Ошибка разбора ответа: {e}")
        return None


def main():
    city = "Moscow"
    weather = get_weather(city)

    if not weather:
        print("Погода не получена или произошла непредвиденная ошибка")
        return

    print(f"Город: {weather['city']}")
    print(f"Температура: {weather['temperature']}C")
    print(f"Погода: {weather['description']}")
    print(f"Влажность: {weather['humidity']}%")
    print(f"Ветер: {weather['wind']} м/с")


if __name__ == "__main__":
    main()