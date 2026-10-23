import tkinter as tk
from tkinter import messagebox


class Product:
    def __init__(self, name, quantity, price):
        # FIX: инкапсуляция — поля сделаны защищёнными
        self._name = name
        self._quantity = quantity
        self._price = price

    # FIX: геттеры для безопасного доступа к полям
    @property
    def name(self):
        return self._name

    @property
    def quantity(self):
        return self._quantity

    @property
    def price(self):
        return self._price

    def update_quantity(self, amount):
        """Обновляет количество товара"""
        self._quantity += amount

    # FIX: логика перенесена в модель (лучше по ООП)
    def total_price(self):
        """Стоимость всех единиц товара"""
        return self._quantity * self._price

    # FIX: добавлен метод строкового представления
    def __str__(self):
        return f"{self._name}, Количество: {self._quantity}, Цена: {self._price}"


class Warehouse:
    def __init__(self):
        self.products = []

    def add_product(self, name, quantity, price):

        # FIX: проверка на существование товара
        if self.find_product(name):
            return "Товар уже существует"

        product = Product(name, quantity, price)
        self.products.append(product)

        return "Товар добавлен"

    # FIX: вынесен общий поиск товара (убирает дублирование)
    def find_product(self, name):
        for product in self.products:
            if product.name == name:
                return product
        return None

    def list_products(self):

        product_list = []

        for product in self.products:
            # FIX: используем __str__ вместо ручного форматирования
            product_list.append(str(product))

        return "\n".join(product_list)

    def remove_product(self, name):

        product = self.find_product(name)  # FIX: использование общего поиска

        if product:
            self.products.remove(product)
            return "Товар удалён"

        return "Товар не найден"

    def update_product_quantity(self, name, amount):

        product = self.find_product(name)  # FIX

        if product:
            product.update_quantity(amount)
            return "Количество обновлено"

        return "Товар не найден"

    def total_inventory_value(self):
        """Общая стоимость склада"""

        total_value = 0

        for product in self.products:
            total_value += product.total_price()  # FIX: используем метод класса Product

        return total_value


class WarehouseApp:
    def __init__(self, master):
        self.master = master
        self.master.title("Управление складом")

        self.warehouse = Warehouse()

        self.name_entry = tk.Entry(master)
        self.name_entry.pack()
        self.name_entry.insert(0, "Название товара")

        self.quantity_entry = tk.Entry(master)
        self.quantity_entry.pack()
        self.quantity_entry.insert(0, "Количество")

        self.price_entry = tk.Entry(master)
        self.price_entry.pack()
        self.price_entry.insert(0, "Цена")

        self.add_button = tk.Button(
            master, text="Добавить товар", command=self.add_product
        )
        self.add_button.pack()

        self.list_button = tk.Button(
            master, text="Показать товары", command=self.show_products
        )
        self.list_button.pack()

        self.remove_button = tk.Button(
            master, text="Удалить товар", command=self.remove_product
        )
        self.remove_button.pack()

        self.update_button = tk.Button(
            master, text="Обновить количество", command=self.update_product
        )
        self.update_button.pack()

        # НЕ НУЖНО: если не требуется вывод списка товаров в окне
        # можно удалить Text и выводить только messagebox
        self.product_display = tk.Text(master, height=10, width=50)
        self.product_display.pack()

    def add_product(self):

        name = self.name_entry.get()

        # FIX: добавлена проверка ввода
        try:
            quantity = int(self.quantity_entry.get())
            price = float(self.price_entry.get())
        except ValueError:
            messagebox.showerror("Ошибка", "Введите корректные числа")
            return

        result = self.warehouse.add_product(name, quantity, price)

        messagebox.showinfo("Информация", result)

    def show_products(self):

        products = self.warehouse.list_products()

        self.product_display.delete(1.0, tk.END)

        if products:
            self.product_display.insert(tk.END, products)
        else:
            self.product_display.insert(tk.END, "Нет товаров на складе")

    def remove_product(self):

        name = self.name_entry.get()

        result = self.warehouse.remove_product(name)

        messagebox.showinfo("Информация", result)

    def update_product(self):

        name = self.name_entry.get()

        # FIX: проверка ввода
        try:
            amount = int(self.quantity_entry.get())
        except ValueError:
            messagebox.showerror("Ошибка", "Введите число")
            return

        result = self.warehouse.update_product_quantity(name, amount)

        messagebox.showinfo("Информация", result)


def main():
    root = tk.Tk()
    app = WarehouseApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()


# НЕ НУЖНО: пример наследования — сейчас в программе не используется
# можно удалить если не требуется расширение типов товаров

# class FoodProduct(Product):
#     pass

# class TechProduct(Product):
#     pass