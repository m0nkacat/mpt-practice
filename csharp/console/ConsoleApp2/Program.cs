using System;

class Program
{
    static void z1(int[,] arr, int n, int m)
    {
        int mult = 1;
        int stroka = 0;
        int minMult = int.MaxValue;
        int minStroka = -1;

        for (int i = 0; i < n; i++)
        {
            mult = 1;
            for (int j = 0; j < m; j++)
            {
                mult *= arr[i, j];
            }
            if (mult < minMult)
            {
                minMult = mult;
                minStroka = i;
            }
        }
        Console.WriteLine(minStroka);
        Console.WriteLine(minMult);
    }
    static void Main(string[] args)
    {

    }
}