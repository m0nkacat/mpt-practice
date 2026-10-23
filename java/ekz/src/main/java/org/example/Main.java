package org.example;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;
import java.nio.file.*;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Product a = new Product(1, "Tovar1", 15.3);
        Product b = new Product(2, "Tovar4", 15.6);
        Product c = new Product(3, "Tovar3", 15.12);
        ArrayList<Product> data = new ArrayList<>();
        data.add(a);
        data.add(b);
        data.add(c);
        boolean flag = true;
        while (flag){
            System.out.println("start");
            System.out.println("1. add");
            System.out.println("2. show all");
            System.out.println("3. delete for name");
            System.out.println("0. exit");
            int count;
            String name;
            double price;
            int chose = scanner.nextInt();
            switch (chose) {
                case 1:
                    count = scanner.nextInt();
                    scanner.nextLine();
                    name = scanner.nextLine();
                    price = scanner.nextDouble();
                    data.add(new Product(count, name, price));
                    break;
                case 2:
                    for(int i = 0; i < data.size(); i++){
                        System.out.println(data.get(i).info());
                    }
                    break;
                case 3:
                    scanner.nextLine();
                    name = scanner.nextLine();
                    for(int i = 0; i < data.size(); i++){
                        if(data.get(i).getName().equals(name)){
                            data.remove(i);
                            break;
                        }
                    }
                    break;
                case 0:
                    System.out.println("end");
                    flag = false;
                    break;
                default:
                    System.out.println("incorect input");
                    break;
            }
        }
    }
}

class Product implements Serializable {
    private int count;
    private String name;
    private double price;

    public Product(int count, String name, double price) {
        this.count = count;
        this.name = name;
        this.price = price;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    public String info() {
        return name + " | цена: " + price + " | кол-во: " + count;
    }
}