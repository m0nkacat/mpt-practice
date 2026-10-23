import java.util.*;

public class Main {
    static Scanner scanner = new Scanner(System.in);
    static List<Employee> employees = new ArrayList<>();

    public static void main(String[] args) {
        employees.add(new Employee("Иван", "IT", 120000, new Date(123, 0, 15), 4.5));
        employees.add(new Employee("Мария", "HR", 80000, new Date(124, 5, 10), 3.2));
        employees.add(new Employee("Петр", "IT", 90000, new Date(122, 8, 20), 4.0));
        employees.add(new Employee("Анна", "HR", 110000, new Date(125, 3, 5), 4.8));
        employees.add(new Employee("Сергей", "Sales", 70000, new Date(124, 11, 1), 2.9));

        boolean a = true;
        while (a) {
            System.out.println("Выберите пункт меню:");
            System.out.println("1 - Фильтрация по отделу с зарплатой выше средней");
            System.out.println("2 - Кол-во сотрудников с рейтингом >3 по отделам");
            System.out.println("3 - Сотрудник с макс зарплатой за последние 2 года");
            System.out.println("4 - Средняя зарплата по отделам");
            System.out.println("0 - Выход");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1: filterByDepartmentAboveAvgSalary(); break;
                case 2: countByDepartmentWithRatingAbove3(); break;
                case 3: findHighestPaidHiredLastTwoYears(); break;
                case 4: averageSalaryByDepartment(); break;
                case 0:
                    System.out.println("Пока!");
                    a = false;
                    break;
                default:
                    System.out.println("Неверный выбор");
            }
        }
    }

    static void filterByDepartmentAboveAvgSalary() {
        System.out.print("Введите отдел: ");
        String department = scanner.nextLine();

        double totalSalary = 0;
        for (int i = 0; i < employees.size(); i++) totalSalary += employees.get(i).salary;
        double avgSalary = totalSalary / employees.size();

        List<Employee> result = new ArrayList<>();
        for (int i = 0; i < employees.size(); i++) {
            Employee e = employees.get(i);
            if (e.department.equals(department) && e.salary > avgSalary) result.add(e);
        }

        if (result.isEmpty()) System.out.println("Нет таких сотрудников");
        else {
            System.out.println("Сотрудники отдела " + department + " с зарплатой выше средней (" + avgSalary + "):");
            for (int i = 0; i < result.size(); i++)
                System.out.println(result.get(i).name + " - " + result.get(i).salary);
        }
    }

    static void countByDepartmentWithRatingAbove3() {
        Map<String, Integer> map = new HashMap<>();
        for (int i = 0; i < employees.size(); i++) {
            Employee e = employees.get(i);
            if (e.performanceRating > 3.0) {
                String dept = e.department;
                map.put(dept, map.getOrDefault(dept, 0) + 1);
            }
        }
        System.out.println("Количество сотрудников с рейтингом >3 по отделам:");
        for (Map.Entry<String, Integer> entry : map.entrySet())
            System.out.println(entry.getKey() + ": " + entry.getValue());
    }

    static void findHighestPaidHiredLastTwoYears() {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.YEAR, -2);
        Date twoYearsAgo = cal.getTime();

        Employee best = null;
        for (int i = 0; i < employees.size(); i++) {
            Employee e = employees.get(i);
            if (e.hireDate.after(twoYearsAgo))
                if (best == null || e.salary > best.salary) best = e;
        }
        if (best != null)
            System.out.println("Сотрудник с максимальной зарплатой за последние 2 года: " + best.name + ", зарплата " + best.salary);
        else
            System.out.println("Нет сотрудников, нанятых за последние 2 года");
    }

    static void averageSalaryByDepartment() {
        Map<String, Double> sumMap = new HashMap<>();
        Map<String, Integer> countMap = new HashMap<>();

        for (int i = 0; i < employees.size(); i++) {
            Employee e = employees.get(i);
            String dept = e.department;
            sumMap.put(dept, sumMap.getOrDefault(dept, 0.0) + e.salary);
            countMap.put(dept, countMap.getOrDefault(dept, 0) + 1);
        }

        System.out.println("Средняя зарплата по отделам:");
        for (String dept : sumMap.keySet())
            System.out.println(dept + ": " + (sumMap.get(dept) / countMap.get(dept)));
    }
}

