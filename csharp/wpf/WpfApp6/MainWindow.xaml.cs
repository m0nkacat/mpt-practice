using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;

namespace Wpf6App
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            UpdateStateDisplay();
        }

       
        private void UpdateStateDisplay()
        {
            string colorName = GetBrushName(Figure.Fill);
            string borderStyle = (Figure.Stroke as SolidColorBrush)?.Color.ToString() ?? "None";
            double thickness = Figure.StrokeThickness;
            StateText.Text = $"Состояние: Цвет = {colorName}, Рамка = {borderStyle}, Толщина = {thickness:F1}";
        }

       
        private string GetBrushName(Brush brush)
        {
            if (brush is SolidColorBrush scb)
            {
                
                if (scb.Color == Colors.DodgerBlue) return "Синий";
                if (scb.Color == Colors.Red) return "Красный";
                if (scb.Color == Colors.Green) return "Зелёный";
                if (scb.Color == Colors.Yellow) return "Жёлтый";
                return scb.Color.ToString();
            }
            return "Неизвестный";
        }

       
        private void ChangeColor_Click(object sender, RoutedEventArgs e)
        {
            
            if (Figure.Fill == Brushes.DodgerBlue)
                Figure.Fill = Brushes.Red;
            else if (Figure.Fill == Brushes.Red)
                Figure.Fill = Brushes.Green;
            else if (Figure.Fill == Brushes.Green)
                Figure.Fill = Brushes.Yellow;
            else
                Figure.Fill = Brushes.DodgerBlue;

            UpdateStateDisplay();
            MessageBox.Show("Цвет изменён", "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        
        private void ChangeBorder_Click(object sender, RoutedEventArgs e)
        {
            if (Figure.Stroke == Brushes.Black)
                Figure.Stroke = Brushes.DarkRed;
            else if (Figure.Stroke == Brushes.DarkRed)
                Figure.Stroke = Brushes.DarkGreen;
            else
                Figure.Stroke = Brushes.Black;

            UpdateStateDisplay();
            MessageBox.Show("Тип рамки изменён", "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
        }

     
        private void ChangeThickness_Click(object sender, RoutedEventArgs e)
        {
            double newThickness = Figure.StrokeThickness + 1;
            if (newThickness > 10)
            {
                MessageBox.Show("Толщина не может превышать 10!", "Предупреждение",
                                MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            Figure.StrokeThickness = newThickness;
            UpdateStateDisplay();
            MessageBox.Show($"Толщина установлена: {newThickness}", "Информация",
                            MessageBoxButton.OK, MessageBoxImage.Information);
        }

       
        private void Reset_Click(object sender, RoutedEventArgs e)
        {
            var result = MessageBox.Show("Сбросить все параметры к начальным?", "Подтверждение",
                                         MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes)
            {
                Figure.Fill = Brushes.DodgerBlue;
                Figure.Stroke = Brushes.Black;
                Figure.StrokeThickness = 2;
                UpdateStateDisplay();
                MessageBox.Show("Параметры сброшены", "Выполнено", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

       
        protected override void OnKeyDown(KeyEventArgs e)
        {
            if (Keyboard.Modifiers == ModifierKeys.Control)
            {
                switch (e.Key)
                {
                    case Key.C:
                        ChangeColor_Click(this, new RoutedEventArgs());
                        e.Handled = true;
                        break;
                    case Key.B:
                        ChangeBorder_Click(this, new RoutedEventArgs());
                        e.Handled = true;
                        break;
                    case Key.T:
                        ChangeThickness_Click(this, new RoutedEventArgs());
                        e.Handled = true;
                        break;
                    case Key.R:
                        Reset_Click(this, new RoutedEventArgs());
                        e.Handled = true;
                        break;
                }
            }
            else if (e.Key == Key.F1)
            {
                About_Click(this, new RoutedEventArgs());
                e.Handled = true;
            }
            base.OnKeyDown(e);
        }

       
        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            var result = MessageBox.Show("Вы действительно хотите выйти?", "Выход",
                                         MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.No)
                e.Cancel = true;
        }

     
        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void About_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Информационный вывод\nВерсия 1.0\n(с) 2025", "О программе",
                            MessageBoxButton.OK, MessageBoxImage.Information);
        }

   
        private void FigureBorder_ContextMenuOpening(object sender, ContextMenuEventArgs e)
        {
    
        }
    }
}