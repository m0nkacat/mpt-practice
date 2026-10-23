public class Employee extends Users {

    public Employee(String login, String password) {
        super(login, password);
    }

    @Override
    public void showMenu(Menu menu) {

        boolean running = true;

        while (running) {

            System.out.println("1. Добавить товар");
            System.out.println("2. Просмотр товаров");
            System.out.println("3. Изменить товар");
            System.out.println("4. Удалить товар");
            System.out.println("5. Экспорт");
            System.out.println("6. Импорт");
            System.out.println("7. Отменить последнее действие");
            System.out.println("0. Выход");

            int choice = menu.scanner.nextInt();

            if (choice == 1) {
                menu.addProduct();
            }
            else if (choice == 2) {
                menu.showProducts();
            }
            else if (choice == 3) {
                menu.editProduct();
            }
            else if (choice == 4) {
                menu.deleteProduct();
            }
            else if (choice == 5) {
                menu.saveToFile();
            }
            else if (choice == 6) {
                menu.loadFromFile();
            }
            else if (choice == 7) {
                menu.cancel_LastAction();
            }
            else if (choice == 0) {
                running = false;
            }
        }
    }
}