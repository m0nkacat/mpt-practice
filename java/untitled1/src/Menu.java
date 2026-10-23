import java.util.*;
import java.io.*;

public class Menu {

    static Scanner scanner = new Scanner(System.in);
    static ArrayList<Product> products = new ArrayList<>();
    static ArrayList<Users> users = new ArrayList<>();
    static int idCounter = 1;
    static Product lastProduct = null;
    static String lastAction = "";

    public void start() {
        loadFromFile();
        users.add(new Employee("admin","admin"));


        boolean running = true;

        while (running) {

            System.out.println("1. Регистрация");
            System.out.println("2. Авторизация");
            System.out.println("0. Выход");

            int choice = scanner.nextInt();

            if (choice == 1) {
                register();
            }
            else if (choice == 2) {
                Users user = login();
                if (user != null) {
                    user.showMenu(this);
                }
            }
            else if (choice == 0) {
                running = false;
            }
        }
    }

    static void register() {

        System.out.print("Логин: ");
        String login = scanner.next();

        System.out.print("Пароль: ");
        String pass = scanner.next();

        System.out.print("Секретный код (для администратора): ");
        String code = scanner.next();

        if (code.equals("123")) {
            users.add(new Employee(login, pass));
        }
        else {
            users.add(new Customer(login, pass));
        }
    }

    static Users login() {

        System.out.print("Логин: ");
        String login = scanner.next();

        System.out.print("Пароль: ");
        String pass = scanner.next();

        for (int i = 0; i < users.size(); i++) {

            Users u = users.get(i);

            if (u.login.equals(login) && u.password.equals(pass)) {
                return u;
            }
        }

        System.out.println("Ошибка входа");
        return null;
    }

    static void addProduct() {

        System.out.print("Название: ");
        String name = scanner.next();

        System.out.print("Цена: ");
        double price = scanner.nextDouble();

        System.out.print("Скидка: ");
        int sale = scanner.nextInt();

        System.out.print("Страна: ");
        String country = scanner.next();

        System.out.print("Категория: ");
        String category = scanner.next();

        Product p = new Product(idCounter++, name, price, sale, country, category);

        products.add(p);
        backgroundSave();
        lastProduct = p;
        lastAction = "add";
        autoSave();
    }

    static void showProducts() {

        for (int i = 0; i < products.size(); i++) {
            System.out.println(products.get(i));
        }
    }

    static void editProduct() {

        showProducts();

        System.out.print("Введите ID: ");
        int id = scanner.nextInt();

        for (int i = 0; i < products.size(); i++) {

            Product p = products.get(i);

            if (p.id == id) {

                lastProduct = new Product(p.id, p.name, p.price, p.sale, p.country, p.category);
                lastAction = "edit";

                System.out.print("Новая цена: ");
                p.price = scanner.nextDouble();

                System.out.print("Новая скидка: ");
                p.sale = scanner.nextInt();

                backgroundSave();

                autoSave();
                break;
            }
        }
    }

    static void deleteProduct() {

        showProducts();

        System.out.print("Введите ID: ");
        int id = scanner.nextInt();

        for (int i = 0; i < products.size(); i++) {

            if (products.get(i).id == id) {

                lastProduct = products.get(i);
                lastAction = "delete";

                products.remove(i);
                backgroundSave();
                autoSave();
                break;
            }
        }
    }

    static void saveToFile() {

        try {

            DataOutputStream out = new DataOutputStream(new FileOutputStream("products.dat"));

            out.writeInt(products.size());

            for (int i = 0; i < products.size(); i++) {

                Product p = products.get(i);

                out.writeInt(p.id);
                out.writeUTF(p.name);
                out.writeDouble(p.price);
                out.writeInt(p.sale);
                out.writeUTF(p.country);
                out.writeUTF(p.category);
            }

            out.close();

        } catch (Exception e) {
            System.out.println("Ошибка сохранения");
        }
    }

    static void loadFromFile() {

        try {

            DataInputStream in = new DataInputStream(new FileInputStream("products.dat"));

            products.clear();

            int size = in.readInt();

            for (int i = 0; i < size; i++) {

                int id = in.readInt();
                String name = in.readUTF();
                double price = in.readDouble();
                int sale = in.readInt();
                String country = in.readUTF();
                String category = in.readUTF();

                products.add(new Product(id, name, price, sale, country, category));
            }

            in.close();

            int maxId = 0;

            for (int i = 0; i < products.size(); i++) {
                if (products.get(i).id > maxId) {
                    maxId = products.get(i).id;
                }
            }

            idCounter = maxId + 1;

        } catch (Exception e) {
            System.out.println("Файл не найден или пуст");
        }
    }

    static void autoSave() {
        saveToFile();
    }

    static void autoImport() {
        loadFromFile();
    }

    static void cancel_LastAction() {

        if (lastAction.equals("add")) {

            products.remove(lastProduct);
            System.out.println("Добавление отменено");
        }

        else if (lastAction.equals("delete")) {

            products.add(lastProduct);
            backgroundSave();
            System.out.println("Удаление отменено");
        }

        else if (lastAction.equals("edit")) {

            for (int i = 0; i < products.size(); i++) {

                if (products.get(i).id == lastProduct.id) {

                    products.set(i, lastProduct);
                    System.out.println("Изменение отменено");
                    break;
                }
            }
        }

        else {
            System.out.println("Нет действия для отмены");
        }

        lastAction = "";
        autoSave();
    }
    static void backgroundSave() {
        saveToFile();
    }

}