using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;

namespace WpfApp5
{
    public partial class MainWindow : Window
    {
        FrameworkElement selected = null;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void ShapeClick(object sender, MouseButtonEventArgs e)
        {
            selected = (FrameworkElement)sender;
            this.Title = selected.Name;
        }

        private void LeftColor(object sender, MouseButtonEventArgs e)
        {
            Button btn = (Button)sender;
            Brush color = btn.Background;

            if (selected is Rectangle rect && rect.Stroke != color)
                rect.Fill = color;
            else if (selected is Ellipse ellipse && ellipse.Stroke != color)
                ellipse.Fill = color;
            else if (selected is Border border && border.BorderBrush != color)
                border.Background = color;
        }

        private void RightColor(object sender, MouseButtonEventArgs e)
        {
            Button btn = (Button)sender;
            Brush color = btn.Background;

            if (selected is Rectangle rect && rect.Fill != color)
                rect.Stroke = color;
            else if (selected is Ellipse ellipse && ellipse.Fill != color)
                ellipse.Stroke = color;
            else if (selected is Border border && border.Background != color)
                border.BorderBrush = color;
        }
        private void ToggleVisibility(object sender, RoutedEventArgs e)
        {
            if (selected != null)
            {
                if (selected.Visibility == Visibility.Visible)
                {
                    selected.Visibility = Visibility.Collapsed;
                }
                else
                {
                    selected.Visibility = Visibility.Visible;
                }
            }
        }
    }
}