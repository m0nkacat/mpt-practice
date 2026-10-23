import java.util.Date;

public class Employee {
    String name;
    String department;
    double salary;
    Date hireDate;
    double performanceRating;

    public Employee(String name, String department, double salary, Date hireDate, double performanceRating) {
        this.name = name;
        this.department = department;
        this.salary = salary;
        this.hireDate = hireDate;
        this.performanceRating = performanceRating;
    }

    public String getName() {
        return name;
    }

    public String getDepartment() {
        return department;
    }

    public double getSalary() {
        return salary;
    }

    public Date getHireDate() {
        return hireDate;
    }

    public double getPerformanceRating() {
        return performanceRating;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }

    public void setPerformanceRating(double performanceRating) {
        this.performanceRating = performanceRating;
    }
}
