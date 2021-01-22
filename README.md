# PlantObserver

![Project Image](/app_preview/mock.jpg)

> Wygląd aplikacji.

---

### Table of Contents
Odnośniki do poszczególnych sekcji.

- [Opis](#Opis)
- [Użytkowanie aplikacji](#Użytkowanie-aplikacji)
- [Działanie](#Działanie)
- [Autorzy](#Autorzy)

---

## Opis

Aplikacja mobilna prezentująca informacje o roślinie takie jak nawodnienie, temperatura, nawiezienie pobrane z symulowanego sensora. 
Przechowywanie pobranych danych na kontach użytkowników przy użyciu Firebase Realtime Database.<br />
Podział prac:<br />
Marcel Kozień - aplikacja, wygląd, architektura<br />
Konrad Pasierbek oraz Maciej Bem - ekran profilu, sensor, raport 

#### Technologie

- Aplikacja: Flutter
- Backend: Firebase Realtime Database
- Sensor: Dart

[Back To The Top](#PlantObserver)

---

## Użytkowanie aplikacji

#### Installation

Aby aplikacja poprawnie funkcjonowała należy dodać klasę ApiKey w której posiadamy klucze do bazy na Firebase. Za sensor odpowiadają pliki w katalogu sensor.

#### ApiKey.dart

```dart
class ApiKey {
  static const String key = 'INSERT KEY';
  static const String dataBaseUrl = 'INSERT URL';
}
```
[Back To The Top](#PlantObserver)

---

#### Działanie

W Folderze app_preview znajdują się zrzuty ekranu z aplikacji oraz film prezentujący jej działanie.

[Back To The Top](#PlantObserver)

---

## Autorzy

- Marcel Kozień - [@Maqcel](https://github.com/Maqcel)
- Maciej Bem - [@maBem](https://github.com/maBem)
- Konrad Pasierbek - [@kondziak](https://github.com/kondziak)

[Back To The Top](#PlantObserver)