using System;
using System.IO;
using System.Text;

class Program
{
    static string z1(string a)
    {
        string new_a = "";
        for (int i = a.Length - 1; i >= 0; i--)
            new_a += a[i];
        return new_a;
    }

    static string z2(string s, string s0)
    {
        return s.Replace(s0, "");
    }

    static string z3(string s)
    {
        string new_s = "";
        string[] words = s.Split(' ', StringSplitOptions.RemoveEmptyEntries);
        for (int i = words.Length - 1; i >= 0; i--)
        {
            new_s += words[i];
            if (i > 0) new_s += " ";
        }
        return new_s;
    }

    static string z4(string s)
    {
        string[] parts = s.Split(' ', StringSplitOptions.RemoveEmptyEntries);
        if (parts.Length == 0) return "0";
        int[] numbers = Array.ConvertAll(parts, int.Parse);
        int max = numbers[0];
        for (int i = 1; i < numbers.Length; i++)
            if (numbers[i] > max) max = numbers[i];
        return max.ToString();
    }

    static string ReadFirstLine(string path)
    {
        using (StreamReader sr = new StreamReader(path, Encoding.UTF8))
            return sr.ReadLine() ?? "";
    }

    static void WriteToFile(string path, string content)
    {
        File.WriteAllText(path, content, Encoding.UTF8);
    }

    static void Main()
    {
        while (true)
        {
            Console.WriteLine("1 — Перевернуть строку");
            Console.WriteLine("2 — Удалить подстроку");
            Console.WriteLine("3 — Перевернуть слова");
            Console.WriteLine("4 — Максимальное число");
            Console.WriteLine("0 — Выход");
            Console.Write("Выбор: ");
            string choice = Console.ReadLine();
            if (choice == "0") break;

            Console.Write("Входной файл: ");
            string inputFile = Console.ReadLine();
            string input = ReadFirstLine(inputFile);
            if (string.IsNullOrEmpty(input))
            {
                Console.WriteLine("Ошибка чтения или файл пуст");
                Console.ReadKey();
                continue;
            }

            string result = "";
            if (choice == "1") result = z1(input);
            else if (choice == "2")
            {
                Console.Write("Подстрока для удаления: ");
                string sub = Console.ReadLine();
                result = z2(input, sub);
            }
            else if (choice == "3") result = z3(input);
            else if (choice == "4")
            {
                try { result = z4(input); }
                catch { Console.WriteLine("Ошибка в числах"); continue; }
            }
            else { Console.WriteLine("Неверный пункт"); continue; }

            Console.Write("Выходной файл: ");
            string outputFile = Console.ReadLine();
            WriteToFile(outputFile, result);
            Console.WriteLine("Готово!");
            Console.ReadKey();
            Console.Clear();
        }
    }
}