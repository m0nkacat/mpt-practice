using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Title = "ура_ты_пикми";
            this.Background = Brushes.Pink;
            pickme_button_2.IsEnabled = true;
        }
        private void Button_Style_Click(object sender, RoutedEventArgs e) {
            pickme_button_2.Background = Brushes.Green;
            pickme_button_2.FontSize = 40;
            pickme_button_2.FontFamily = new FontFamily("Times New Roman");
            button.Visibility = Visibility.Hidden;
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            pickme_button_2.IsEnabled = false;
        }
    }
}