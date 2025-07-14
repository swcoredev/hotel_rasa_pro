# 🎯 Установка Rasa Studio на сервер

## 📋 Предварительная проверка сервера

### 1. Подключение к серверу
```bash
ssh adminservis@100.111.172.61
# Пароль: 80975509004Gen@
```

### 2. Проверка системных требований

#### Проверка ОС (должна быть Ubuntu 22.04/24.04 или RHEL 9):
```bash
cat /etc/os-release
uname -a
```

#### Проверка ресурсов (минимум: 4 vCPU, 16GB RAM, 100GB):
```bash
# Проверка CPU
nproc
lscpu | grep 'Model name'

# Проверка RAM
free -h

# Проверка дискового пространства
df -h
df -h /home
```

#### Проверка открытых портов:
```bash
sudo netstat -tlnp | grep -E ':(22|443|30000|30002)'
```

#### Проверка прав sudo:
```bash
sudo -l
```

#### Проверка DNS:
```bash
hostname -f
nslookup 100.111.172.61
```

---

## 🚀 Установка Rasa Studio (Replicated)

### Шаг 1: Подготовка системы
```bash
# Обновление системы
sudo apt update && sudo apt upgrade -y

# Установка необходимых пакетов
sudo apt install -y curl wget tar gzip

# Проверка версии Python (если нужен)
python3 --version
```

### Шаг 2: Скачивание Rasa Studio
```bash
# Создание директории для установки
mkdir -p ~/rasa-studio-install
cd ~/rasa-studio-install

# Скачивание установочного пакета
# ЗАМЕНИТЕ YOUR_LICENSE_KEY на ваш реальный ключ лицензии
curl -f "https://replicated.rasa.com/embedded/studio-dragon/stable" \
  -H "Authorization: YOUR_LICENSE_KEY" \
  -o studio-dragon-stable.tgz
```

### Шаг 3: Распаковка и установка
```bash
# Распаковка архива
tar -xvzf studio-dragon-stable.tgz

# Проверка содержимого
ls -la

# Установка (замените license.yaml на ваш файл лицензии)
sudo ./studio-dragon install --license license.yaml
```

### Шаг 4: Настройка через веб-интерфейс
```bash
# После установки откройте в браузере:
# https://100.111.172.61:30000
# или
# https://your-domain.com:30000 (если настроен DNS)
```

---

## 🔧 Альтернативная установка через Helm (если есть Kubernetes)

### Предварительные требования:
```bash
# Проверка Helm
helm version

# Проверка Kubernetes
kubectl version --client
kubectl cluster-info
```

### Установка через Helm:
```bash
# Добавление репозитория Rasa
helm repo add rasa https://helm.rasa.com
helm repo update

# Установка Rasa Studio
helm install rasa-studio rasa/rasa-studio \
  --namespace rasa-studio \
  --create-namespace \
  --set license.key="YOUR_LICENSE_KEY"
```

---

## 📝 Конфигурация после установки

### 1. Настройка домена (если есть):
```bash
# В Admin Console (порт 30000):
# - Настройте домен
# - Настройте SSL сертификаты
# - Настройте SMTP для уведомлений
```

### 2. Подключение к Rasa Pro:
```bash
# В локальном проекте:
rasa studio config
# Укажите URL вашей Studio: https://100.111.172.61:30000

# Загрузка проекта:
rasa studio upload
```

---

## 🔍 Диагностика проблем

### Проверка статуса сервисов:
```bash
# Проверка процессов
ps aux | grep studio
ps aux | grep replicated

# Проверка логов
sudo journalctl -u replicated -f
sudo journalctl -u studio -f

# Проверка портов
sudo netstat -tlnp | grep -E ':(30000|443)'
```

### Проверка ресурсов:
```bash
# Мониторинг ресурсов
htop
df -h
free -h
```

---

## 📞 Поддержка

### Полезные команды:
```bash
# Перезапуск сервисов
sudo systemctl restart replicated
sudo systemctl restart studio

# Проверка статуса
sudo systemctl status replicated
sudo systemctl status studio

# Просмотр логов
sudo tail -f /var/log/replicated/replicated.log
```

### Контакты:
- Rasa Documentation: https://rasa.com/docs/studio/
- Rasa Support: https://rasa.com/support/

---

## ✅ Чек-лист установки

- [ ] Сервер соответствует требованиям (ОС, ресурсы)
- [ ] Порты 22, 443, 30000, 30002 открыты
- [ ] Есть права sudo
- [ ] Скачан установочный пакет
- [ ] Установлен Rasa Studio
- [ ] Настроен веб-интерфейс
- [ ] Настроен домен (опционально)
- [ ] Подключен локальный проект
- [ ] Протестирована работа

---

**🎉 После выполнения всех шагов Rasa Studio будет доступен по адресу:**
**https://100.111.172.61:30000** 