import matplotlib.pyplot as plt
import seaborn as sns

requests = ['GET', 'POST', 'PUT', 'DELETE']
count = [120, 80, 45, 20]

sns.barplot(x=requests, y=count)
plt.title('Статистика HTTP-запросов')
plt.xlabel('Тип запросов')
plt.ylabel('Количество')

plt.savefig('requests_stats.png')
plt.show()