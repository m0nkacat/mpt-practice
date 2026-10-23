using System;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace CalcWpf
{
    public partial class MainWindow : Window
    {
        private double a = 0;
        private string op = "";
        private bool newInput = true;
        private const int MaxDigits = 15;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void InputBox_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            e.Handled = !Regex.IsMatch(e.Text, @"[0-9\.\-]");
        }

        private void InputBox_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
                Equal_Click(sender, e);
        }

        private double GetVal()
        {
            string cleaned = InputBox.Text.Replace(",", "").Replace(" ", "");
            double.TryParse(cleaned, NumberStyles.Any, CultureInfo.InvariantCulture, out double v);
            return v;
        }

        private void SetVal(double v)
        {
            string formatted;
            if (Math.Abs(v - Math.Truncate(v)) < 1e-10)
                formatted = v.ToString("N0", CultureInfo.InvariantCulture);
            else
                formatted = v.ToString("N2", CultureInfo.InvariantCulture);

            formatted = formatted.Replace(",", " ");

            string digitsOnly = formatted.Replace(" ", "").Replace("-", "");
            if (digitsOnly.Length > MaxDigits)
            {
                MessageBox.Show($"Число не может содержать более {MaxDigits} цифр", "Ограничение",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                InputBox.Text = "0";
                newInput = true;
                return;
            }
            InputBox.Text = formatted;
            newInput = true;
        }

        private void Add(string t)
        {
            if (newInput || InputBox.Text == "0")
            {
                InputBox.Text = t;
                newInput = false;
                return;
            }
            if (!IsInputAllowed(InputBox.Text, t))
            {
                MessageBox.Show($"Максимум {MaxDigits} цифр", "Ограничение", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            InputBox.Text += t;
        }

        private bool IsInputAllowed(string currentText, string addedChar)
        {
            if (addedChar == "." && currentText.Contains("."))
                return false;
            string newText = currentText + addedChar;
            string digits = Regex.Replace(newText, @"[^0-9\-]", "");
            if (digits.StartsWith("-"))
                digits = digits.Substring(1);
            return digits.Length <= MaxDigits;
        }

        private void Digit_Click(object sender, RoutedEventArgs e)
        {
            Add(((Button)sender).Content.ToString());
        }

        private void Dot_Click(object sender, RoutedEventArgs e)
        {
            if (!InputBox.Text.Contains("."))
                Add(".");
        }

        private void Op_Click(object sender, RoutedEventArgs e)
        {
            a = GetVal();
            op = ((Button)sender).Content.ToString();
            newInput = true;
        }

        private void Equal_Click(object sender, RoutedEventArgs e)
        {
            double b = GetVal();
            double r = 0;
            try
            {
                switch (op)
                {
                    case "+": r = a + b; break;
                    case "-": r = a - b; break;
                    case "*": r = a * b; break;
                    case "/":
                        if (b == 0) throw new Exception("Деление на ноль");
                        r = a / b;
                        break;
                    default:
                        SetVal(b);
                        newInput = true;
                        return;
                }
                SetVal(r);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                InputBox.Text = "0";
                newInput = true;
            }
        }

        private void Clear_Click(object sender, RoutedEventArgs e)
        {
            InputBox.Text = "0";
            newInput = true;
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            if (InputBox.Text.Length > 1)
                InputBox.Text = InputBox.Text.Substring(0, InputBox.Text.Length - 1);
            else
                InputBox.Text = "0";
        }

        private void Sign_Click(object sender, RoutedEventArgs e)
        {
            SetVal(-GetVal());
        }

        private void Sqrt_Click(object sender, RoutedEventArgs e)
        {
            double v = GetVal();
            if (v < 0)
            {
                MessageBox.Show("Нельзя извлечь корень из отрицательного числа", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            SetVal(Math.Sqrt(v));
        }
    }
}