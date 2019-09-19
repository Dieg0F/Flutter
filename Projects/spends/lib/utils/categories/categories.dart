String getIconByCategory(String category) {
  switch (category) {
    case "Contas":
      return "assets/icons/icon-bill.png";
      break;
    case "Transporte":
      return "assets/icons/icon-car.png";
      break;
    case "Roupas":
      return "assets/icons/icon-clothes.png";
      break;
    case "Cartão de Credito":
      return "assets/icons/icon-credit-card.png";
      break;
    case "Estudos":
      return "assets/icons/icon-education.png";
      break;
    case "Familia":
      return "assets/icons/icon-family.png";
      break;
    case "Comida":
      return "assets/icons/icon-foods.png";
      break;
    case "Saúde":
      return "assets/icons/icon-hosptal.png";
      break;
    case "Casa":
      return "assets/icons/icon-house.png";
      break;
    case "Telefone":
      return "assets/icons/icon-phone.png";
      break;
    case "Remédio":
      return "assets/icons/icon-remedy.png";
      break;
    case "Compras":
      return "assets/icons/icon-shopping.png";
      break;
    case "Esportes":
      return "assets/icons/icon-sports.png";
      break;
    case "Transações":
      return "assets/icons/icon-trade.png";
      break;
    case "Viagens":
      return "assets/icons/icon-travel.png";
      break;
    default:
      return "assets/icons/icon-default.png";
  }
}

List<String> getAllCategories() {
  List<String> cat = new List<String>();
  cat.add("Contas");
  cat.add("Transporte");
  cat.add("Roupas");
  cat.add("Cartão de Credito");
  cat.add("Estudos");
  cat.add("Familia");
  cat.add("Comida");
  cat.add("Saúde");
  cat.add("Casa");
  cat.add("Telefone");
  cat.add("Remédio");
  cat.add("Compras");
  cat.add("Esportes");
  cat.add("Transações");
  cat.add("Viagens");

  return cat;
}
