
namespace ConsoleApp8
{
    internal class Program
    {
        static void Main(string[] args)
        {
            try
            {
                int a = int.Parse(Console.ReadLine());
                int b = int.Parse(Console.ReadLine());
                if (b == 0)
                {
                    Console.WriteLine("на ноль не дели");

                }
                else { 
                    Console.WriteLine(a/b);
                }
            }
            catch (Exception FormatException) { 
                Console.WriteLine(FormatException.Message);
            }
            }
    }
}





