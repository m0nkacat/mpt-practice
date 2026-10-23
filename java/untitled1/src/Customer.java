public class Customer extends Users {

    public Customer(String login, String password) {
        super(login, password);
    }

    @Override
    public void showMenu(Menu menu) {

        boolean running = true;

        while (running) {

            System.out.println("1. Просмотр товаров");
            System.out.println("0. Выход");

            int choice = menu.scanner.nextInt();

            if (choice == 1) {
                menu.showProducts();
            }
            else if (choice == 0) {
                running = false;
            }
        }
    }
}