# 🚀 Быстрый старт: Rasa Studio на сервере

## 📋 Что у нас есть

**Сервер:** `100.111.172.61`  
**Пользователь:** `adminservis`  
**Пароль:** `80975509004Gen@`  
**Статус:** ✅ Доступен (ping проходит)

## 🔍 Что нужно проверить на сервере

Подключитесь к серверу и выполните эти команды:

```bash
ssh adminservis@100.111.172.61
# Введите пароль: 80975509004Gen@
```

### 1. Проверка ОС и ресурсов
```bash
# ОС (должна быть Ubuntu 22.04/24.04 или RHEL 9)
cat /etc/os-release

# CPU (минимум 4 ядра)
nproc
lscpu | grep 'Model name'

# RAM (минимум 16GB)
free -h

# Диск (минимум 100GB)
df -h
```

### 2. Проверка портов и прав
```bash
# Открытые порты
sudo netstat -tlnp | grep -E ':(22|443|30000|30002)'

# Права sudo
sudo -l
```

## 🎯 Если все требования выполнены

### Установка Rasa Studio:

1. **Скачайте установочный пакет:**
   ```bash
   mkdir -p ~/rasa-studio-install
   cd ~/rasa-studio-install
   
   # ЗАМЕНИТЕ YOUR_LICENSE_KEY на ваш ключ
   curl -f "https://replicated.rasa.com/embedded/studio-dragon/stable" \
     -H "Authorization: YOUR_LICENSE_KEY" \
     -o studio-dragon-stable.tgz
   ```

2. **Установите:**
   ```bash
   tar -xvzf studio-dragon-stable.tgz
   sudo ./studio-dragon install --license license.yaml
   ```

3. **Откройте веб-интерфейс:**
   ```
   https://100.111.172.61:30000
   ```

## 🔗 Подключение локального проекта

После установки Studio:

```bash
# В локальном проекте
rasa studio config
# URL: https://100.111.172.61:30000

rasa studio upload
```

## 📚 Подробная инструкция

См. файл: `RASA_STUDIO_INSTALLATION.md`

## ⚠️ Важно

- **Лицензионный ключ:** Вам нужен корпоративный аккаунт Rasa и лицензионный ключ
- **Ресурсы:** Убедитесь, что сервер соответствует минимальным требованиям
- **Порты:** Порты 30000 и 443 должны быть открыты
- **DNS:** Для продакшена настройте домен

## 🆘 Если что-то не работает

1. Проверьте логи: `sudo journalctl -u replicated -f`
2. Проверьте статус: `sudo systemctl status replicated`
3. Перезапустите: `sudo systemctl restart replicated`

---

**🎉 После успешной установки вы сможете управлять Rasa Pro через веб-интерфейс!** 