public abstract class Users {

    String login;
    String password;

    public Users(String login, String password) {
        this.login = login;
        this.password = password;
    }

    public abstract void showMenu(Menu menu);
}