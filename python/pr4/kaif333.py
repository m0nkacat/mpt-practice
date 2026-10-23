import csv
import json

animal = [
    ["Животное", "Возраст", "Номер вальера"],
    ["Тигр", "6", "1"],
    ["Жираф", "5", "2"],
    ["Медведь", "4", "4"],
    ["Леопард", "5", "3"]
]


csv_filename = 'animal.csv'
with open(csv_filename, 'w', encoding='utf-8', newline='') as file_csv:
    writer = csv.writer(file_csv)
    writer.writerows(animal)


json_zoo = "zoo.json"
animal_json = []

with open(csv_filename, mode='r', encoding='utf-8') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    for row in csv_reader:
        animal_json.append(row)

with open(json_zoo, mode='w', encoding='utf-8') as json_file:
    json.dump(animal_json, json_file, ensure_ascii=False, indent=2)


employees = [["Имя", "Возраст", "Город", "Должность"],
            ["Миша", "12", "Москва", "Разработчик"],
            ["Михаил", "13", "Балашиха", "Менеджер"],
            ["Мишаня", "14", "Сочи", "Дизайнер"]]

rabi = "employees.csv"
rabi_no_s_zp = "employees_with_salary.csv"

with open(rabi, 'w', encoding='utf-8', newline='') as file_csv:
    writer = csv.writer(file_csv)
    writer.writerows(employees)

employees_with_salary = []

salary_map = {
    "Разработчик": "120000",
    "Менеджер": "100000",
    "Дизайнер": "90000"
}

with open(rabi, mode='r', encoding='utf-8') as csv_file:
    csv_reader = csv.reader(csv_file)
    for i, row in enumerate(csv_reader):
        if i == 0:
            row.append("Зарплата")
        else:
            position = row[3] 
            salary = salary_map.get(position, "Неизвестно")
            row.append(salary)
        employees_with_salary.append(row)

with open(rabi_no_s_zp, mode = 'w', encoding='utf-8') as csv_file:
    writer = csv.writer(csv_file)
    writer.writerows(employees_with_salary)