import 'car/car.dart';

Car getCar() {
  var jsonObject = {
    "id": "5d5c198e642e9abe75f5ca96",
    "brand": {
      "id": "5d5c198e165fad5c8fa3ffa5",
      "name": "Jarvis",
      "logo": "Church"
    },
    "vehicle": {
      "id": "5d5c198e3dfe66366552f811",
      "name": "Blevins",
      "version": "May",
      "engine": "Bailey",
      "fuel": "Suzanne",
      "gear": "Nieves",
      "doors": "Mccray"
    },
    "year": 1983,
    "photoGallery": [
      {
        "photoPath":
            "https://image.cnbcfm.com/api/v1/image/105807049-1553189463674bugatti.jpg?v=1553189697&w=640&h=480",
        "uploadDate": "Friday, March 25, 2016 6:51 AM"
      },
      {
        "photoPath":
            "https://image.cnbcfm.com/api/v1/image/105807049-1553189463674bugatti.jpg?v=1553189697&w=640&h=480",
        "uploadDate": "Tuesday, December 16, 2014 7:26 PM"
      },
      {
        "photoPath":
            "https://image.cnbcfm.com/api/v1/image/105807049-1553189463674bugatti.jpg?v=1553189697&w=640&h=480",
        "uploadDate": "Thursday, May 23, 2019 12:01 AM"
      }
    ],
    "description":
        "Mollit laborum laboris ipsum nostrud. Excepteur in veniam cupidatat laboris adipisicing do aliquip reprehenderit. Laboris excepteur amet tempor ad exercitation sunt. Aute elit laboris laborum cillum ea excepteur do nisi. Id eu laborum fugiat dolore ut exercitation amet reprehenderit nostrud ut anim sint amet pariatur. Deserunt culpa commodo excepteur aliquip sunt ex et sit occaecat non elit. Aliqua enim nostrud do culpa sit consectetur cupidatat."
  };

  return Car.fromJson(jsonObject);
}
