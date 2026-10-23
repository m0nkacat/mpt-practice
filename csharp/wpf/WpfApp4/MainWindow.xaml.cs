using System;
using System.Windows;
using System.Windows.Threading;

namespace WpfApp4
{
    public partial class MainWindow : Window
    {
        DispatcherTimer timer = new DispatcherTimer();
        int pos = 0;

        public MainWindow()
        {
            InitializeComponent();

            // фикс поведения без XAML
            Label.HorizontalAlignment = HorizontalAlignment.Center;
            Label.VerticalAlignment = VerticalAlignment.Center;
            Label.HorizontalContentAlignment = HorizontalAlignment.Center;
            Label.VerticalContentAlignment = VerticalAlignment.Center;

            timer.Interval = TimeSpan.FromSeconds(1);
            timer.Tick += Clock;
            timer.Start();
        }

        private void Clock(object sender, EventArgs e)
        {
            if (pos == 0)
            {
                Label.HorizontalAlignment = HorizontalAlignment.Left;
                Label.VerticalAlignment = VerticalAlignment.Bottom;
            }
            else if (pos == 1)
            {
                Label.HorizontalAlignment = HorizontalAlignment.Center;
                Label.VerticalAlignment = VerticalAlignment.Center;
            }
            else
            {
                Label.HorizontalAlignment = HorizontalAlignment.Right;
                Label.VerticalAlignment = VerticalAlignment.Top;
            }

            pos = (pos + 1) % 3;
        }
    }
}