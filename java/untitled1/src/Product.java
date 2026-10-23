public class Product {

    int id;
    String name;
    double price;
    int sale;
    String country;
    String category;

    public Product(int id, String name, double price, int sale, String country, String category) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.sale = sale;
        this.country = country;
        this.category = category;
    }

    public String toFile() {
        return id + ";" + name + ";" + price + ";" + sale + ";" + country + ";" + category;
    }

    public String toString() {
        return id + " | " + name + " | " + price + " | скидка: " + sale + "% | " + country + " | " + category;
    }
}