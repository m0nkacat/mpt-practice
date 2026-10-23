using Microsoft.Win32;
using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;

namespace WpfApp7
{
    public partial class MainWindow : Window
    {
        private string currentFilePath = "";
        private bool isTextChanged = false;

        public MainWindow()
        {
            InitializeComponent();
            this.Loaded += (s, e) =>
            {
                UpdateStatistics();
                Editor.TextChanged += (sender, args) => { if (AutoUpdateStatsCheck.IsChecked == true) UpdateStatistics(); };
                Editor.SelectionChanged += (sender, args) => { if (AutoUpdateStatsCheck.IsChecked == true) UpdateStatistics(); };
            };
        }

        private (int chars, int charsNoSpace, int words, int lines, int paragraphs) GetTextStats(string text)
        {
            if (string.IsNullOrEmpty(text)) return (0, 0, 0, 0, 0);
            int chars = text.Length;
            int charsNoSpace = text.Count(c => !char.IsWhiteSpace(c));
            string[] words = text.Split(new char[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
            int wordsCount = words.Length;
            int lines = text.Split('\n').Length;
            string[] paragraphs = text.Split(new string[] { "\r\n\r\n", "\n\n" }, StringSplitOptions.RemoveEmptyEntries);
            int paragraphsCount = paragraphs.Length;
            return (chars, charsNoSpace, wordsCount, lines, paragraphsCount);
        }

        private void UpdateStatistics()
        {
            if (StatsModeCombo == null || StatsModeCombo.SelectedIndex == -1) return;
            bool wholeDocument = (StatsModeCombo.SelectedIndex == 0);
            string sourceText = wholeDocument ? Editor.Text : Editor.SelectedText;
            var stats = GetTextStats(sourceText);
            StatsChars.Text = stats.chars.ToString();
            StatsCharsNoSpace.Text = stats.charsNoSpace.ToString();
            StatsWords.Text = stats.words.ToString();
            StatsLines.Text = stats.lines.ToString();
            StatsParagraphs.Text = stats.paragraphs.ToString();
            QuickStatsText.Text = $"Слов: {stats.words} | Строк: {stats.lines}";
        }

        private void StatsModeCombo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (AutoUpdateStatsCheck != null && AutoUpdateStatsCheck.IsChecked == true)
                UpdateStatistics();
        }

        private void AutoUpdateStats_Changed(object sender, RoutedEventArgs e)
        {
            if (UpdateStatsBtn == null) return;
            bool auto = AutoUpdateStatsCheck.IsChecked == true;
            UpdateStatsBtn.Visibility = auto ? Visibility.Collapsed : Visibility.Visible;
            if (auto) UpdateStatistics();
        }

        private void UpdateStatsBtn_Click(object sender, RoutedEventArgs e) => UpdateStatistics();

        private void NewFile_Click(object sender, RoutedEventArgs e)
        {
            if (!CheckSaveBeforeAction()) return;
            Editor.Clear();
            currentFilePath = "";
            isTextChanged = false;
            Title = "Новый файл — Блокнот";
            UpdateStatus();
        }

        private void OpenFile_Click(object sender, RoutedEventArgs e)
        {
            if (!CheckSaveBeforeAction()) return;
            OpenFileDialog dialog = new OpenFileDialog { Title = "Открыть файл", Filter = "Текстовые файлы (*.txt)|*.txt|Все файлы (*.*)|*" };
            if (dialog.ShowDialog() == true)
            {
                Editor.Text = File.ReadAllText(dialog.FileName, Encoding.UTF8);
                currentFilePath = dialog.FileName;
                isTextChanged = false;
                Title = currentFilePath + " — Блокнот";
                UpdateStatus();
            }
        }

        private void SaveFile_Click(object sender, RoutedEventArgs e) => SaveFile();
        private void SaveAsFile_Click(object sender, RoutedEventArgs e) => SaveFileAs();
        private void Exit_Click(object sender, RoutedEventArgs e) => Close();

        private bool SaveFile()
        {
            if (string.IsNullOrEmpty(currentFilePath)) return SaveFileAs();
            File.WriteAllText(currentFilePath, Editor.Text, Encoding.UTF8);
            isTextChanged = false;
            Title = currentFilePath + " — Блокнот";
            UpdateStatus();
            return true;
        }

        private bool SaveFileAs()
        {
            SaveFileDialog dialog = new SaveFileDialog { Title = "Сохранить файл как", Filter = "Текстовые файлы (*.txt)|*.txt|Все файлы (*.*)|*", FileName = "Новый документ.txt" };
            if (dialog.ShowDialog() == true)
            {
                currentFilePath = dialog.FileName;
                return SaveFile();
            }
            return false;
        }

        private void Undo_Click(object sender, RoutedEventArgs e) { if (Editor.CanUndo) Editor.Undo(); }
        private void Redo_Click(object sender, RoutedEventArgs e) { if (Editor.CanRedo) Editor.Redo(); }
        private void Cut_Click(object sender, RoutedEventArgs e) => Editor.Cut();
        private void Copy_Click(object sender, RoutedEventArgs e) => Editor.Copy();
        private void Paste_Click(object sender, RoutedEventArgs e) => Editor.Paste();
        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            if (Editor.SelectionLength > 0)
                Editor.Text = Editor.Text.Remove(Editor.SelectionStart, Editor.SelectionLength);
        }
        private void SelectAll_Click(object sender, RoutedEventArgs e) => Editor.SelectAll();

        private void WordWrap_Click(object sender, RoutedEventArgs e)
        {
            MenuItem item = sender as MenuItem;
            if (item != null)
                Editor.TextWrapping = item.IsChecked ? TextWrapping.Wrap : TextWrapping.NoWrap;
        }

        private void IncreaseFont_Click(object sender, RoutedEventArgs e) => Editor.FontSize += 2;
        private void DecreaseFont_Click(object sender, RoutedEventArgs e) { if (Editor.FontSize > 8) Editor.FontSize -= 2; }

        private void ShowFindPanel_Click(object sender, RoutedEventArgs e)
        {
            FindPanel.Visibility = Visibility.Visible;
            ReplaceTextBlock.Visibility = Visibility.Collapsed;
            ReplaceTextBox.Visibility = Visibility.Collapsed;
            ReplaceButton.Visibility = Visibility.Collapsed;
            ReplaceAllButton.Visibility = Visibility.Collapsed;
            FindTextBox.Focus();
        }

        private void ShowReplacePanel_Click(object sender, RoutedEventArgs e)
        {
            FindPanel.Visibility = Visibility.Visible;
            ReplaceTextBlock.Visibility = Visibility.Visible;
            ReplaceTextBox.Visibility = Visibility.Visible;
            ReplaceButton.Visibility = Visibility.Visible;
            ReplaceAllButton.Visibility = Visibility.Visible;
            FindTextBox.Focus();
        }

        private void CloseFindPanel_Click(object sender, RoutedEventArgs e)
        {
            FindPanel.Visibility = Visibility.Collapsed;
            Editor.Focus();
        }

        private void FindNext_Click(object sender, RoutedEventArgs e) => FindNext();

        private void FindNext()
        {
            string findText = FindTextBox.Text;
            if (string.IsNullOrEmpty(findText))
            {
                MessageBox.Show("Введите текст для поиска.", "Поиск", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            StringComparison comparison = (CaseSensitiveCheckBox.IsChecked == true) ? StringComparison.CurrentCulture : StringComparison.CurrentCultureIgnoreCase;
            int startIndex = Editor.SelectionStart + Editor.SelectionLength;
            int index = Editor.Text.IndexOf(findText, startIndex, comparison);
            if (index == -1 && startIndex > 0) index = Editor.Text.IndexOf(findText, 0, comparison);
            if (index >= 0)
            {
                Editor.Focus();
                Editor.Select(index, findText.Length);
                int line = Editor.GetLineIndexFromCharacterIndex(index);
                Editor.ScrollToLine(line);
            }
            else MessageBox.Show("Текст не найден.", "Поиск", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void Replace_Click(object sender, RoutedEventArgs e)
        {
            string findText = FindTextBox.Text;
            string replaceText = ReplaceTextBox.Text;
            if (string.IsNullOrEmpty(findText))
            {
                MessageBox.Show("Введите текст для поиска.", "Замена", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            StringComparison comparison = (CaseSensitiveCheckBox.IsChecked == true) ? StringComparison.CurrentCulture : StringComparison.CurrentCultureIgnoreCase;
            if (Editor.SelectedText.Equals(findText, comparison))
                Editor.SelectedText = replaceText;
            FindNext();
        }

        private void ReplaceAll_Click(object sender, RoutedEventArgs e)
        {
            string findText = FindTextBox.Text;
            string replaceText = ReplaceTextBox.Text;
            if (string.IsNullOrEmpty(findText))
            {
                MessageBox.Show("Введите текст для поиска.", "Замена", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }
            StringComparison comparison = (CaseSensitiveCheckBox.IsChecked == true) ? StringComparison.CurrentCulture : StringComparison.CurrentCultureIgnoreCase;
            string text = Editor.Text;
            int count = 0;
            int index = 0;
            while ((index = text.IndexOf(findText, index, comparison)) != -1)
            {
                text = text.Remove(index, findText.Length);
                text = text.Insert(index, replaceText);
                index += replaceText.Length;
                count++;
            }
            Editor.Text = text;
            MessageBox.Show($"Выполнено замен: {count}", "Замена", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void PrintFile_Click(object sender, RoutedEventArgs e)
        {
            PrintDialog dialog = new PrintDialog();
            if (dialog.ShowDialog() == true)
            {
                FlowDocument doc = new FlowDocument(new Paragraph(new Run(Editor.Text)));
                doc.PageWidth = dialog.PrintableAreaWidth;
                doc.PageHeight = dialog.PrintableAreaHeight;
                dialog.PrintDocument(((IDocumentPaginatorSource)doc).DocumentPaginator, "Печать документа");
            }
        }

        private void About_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("WPF-Блокнот\n\nПрограмма позволяет создавать, открывать, редактировать, сохранять и печатать текстовые файлы.", "О программе", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void Editor_TextChanged(object sender, TextChangedEventArgs e)
        {
            isTextChanged = true;
            if (string.IsNullOrEmpty(currentFilePath)) Title = "Новый файл * — Блокнот";
            else Title = currentFilePath + " * — Блокнот";
            UpdateStatus();
        }

        private void Editor_SelectionChanged(object sender, RoutedEventArgs e) => UpdateStatus();

        private void UpdateStatus()
        {
            int caretIndex = Editor.CaretIndex;
            int line = Editor.GetLineIndexFromCharacterIndex(caretIndex);
            int column = caretIndex - Editor.GetCharacterIndexFromLineIndex(line);
            LineColumnText.Text = "Строка: " + (line + 1) + ", Столбец: " + (column + 1);
            CharCountText.Text = "Символов: " + Editor.Text.Length;
            FilePathText.Text = string.IsNullOrEmpty(currentFilePath) ? "Новый файл" : currentFilePath;
        }

        private bool CheckSaveBeforeAction()
        {
            if (!isTextChanged) return true;
            MessageBoxResult result = MessageBox.Show("Файл был изменён. Сохранить изменения?", "Сохранение", MessageBoxButton.YesNoCancel, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes) return SaveFile();
            if (result == MessageBoxResult.No) return true;
            return false;
        }

        protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
        {
            if (!CheckSaveBeforeAction()) e.Cancel = true;
            base.OnClosing(e);
        }
    }
}