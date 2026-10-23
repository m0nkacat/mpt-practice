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
using System.Windows.Threading;

namespace WpfApp2
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        DispatcherTimer timer = new DispatcherTimer();

        public MainWindow()
        {
            InitializeComponent();
            timer.Interval = TimeSpan.FromSeconds(3);
            timer.Tick += Clock;
            timer.Start();
        }

        private void Clock(object sender, EventArgs e)
        {
            text_block.Text = DateTime.Now.ToString("HH:mm:ss");
        }
        private void button_Click(object sender, RoutedEventArgs e)
        {
            text_block.HorizontalAlignment = HorizontalAlignment.Right;
            text_block.VerticalAlignment = VerticalAlignment.Bottom;
            text_block.FontSize = 40;
            text_block.Text = DateTime.Now.ToString("HH:mm:ss");
        }
    }
}