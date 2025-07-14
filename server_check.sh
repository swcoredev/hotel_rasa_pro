#!/bin/bash

# Скрипт для автоматической проверки сервера
SERVER_IP="100.111.172.61"
USER="adminservis"
PASSWORD="80975509004Gen@"

echo "🔍 Автоматическая проверка сервера $SERVER_IP"
echo "=============================================="

# Функция для выполнения команды на сервере
execute_on_server() {
    local command="$1"
    local description="$2"
    
    echo ""
    echo "📋 $description"
    echo "----------------------------------------"
    
    # Используем sshpass для автоматического ввода пароля
    if command -v sshpass &> /dev/null; then
        sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USER@$SERVER_IP" "$command" 2>/dev/null
    else
        echo "⚠️  sshpass не установлен. Установите его для автоматической проверки:"
        echo "   brew install sshpass  # macOS"
        echo "   sudo apt install sshpass  # Ubuntu"
        echo ""
        echo "Или выполните команды вручную на сервере:"
        echo "ssh $USER@$SERVER_IP"
        echo "$command"
    fi
}

# Проверка подключения
echo "📡 Проверка подключения..."
ping -c 3 "$SERVER_IP" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Сервер доступен"
else
    echo "❌ Сервер недоступен"
    exit 1
fi

# Выполнение проверок на сервере
execute_on_server "cat /etc/os-release" "Информация об ОС"
execute_on_server "uname -a" "Информация о ядре"
execute_on_server "nproc" "Количество CPU ядер"
execute_on_server "lscpu | grep 'Model name'" "Модель процессора"
execute_on_server "free -h" "Информация о RAM"
execute_on_server "df -h" "Информация о дисках"
execute_on_server "sudo -l" "Права sudo"
execute_on_server "hostname -f" "Полное имя хоста"
execute_on_server "python3 --version" "Версия Python"
execute_on_server "docker --version" "Версия Docker (если установлен)"
execute_on_server "helm version" "Версия Helm (если установлен)"

echo ""
echo "=============================================="
echo "📊 Анализ результатов:"
echo ""

# Проверка минимальных требований
echo "🔍 Проверка минимальных требований для Rasa Studio:"
echo "   - ОС: Ubuntu 22.04/24.04 или RHEL 9"
echo "   - CPU: минимум 4 ядра"
echo "   - RAM: минимум 16GB"
echo "   - Диск: минимум 100GB свободного места"
echo "   - Порты: 22, 443, 30000, 30002 должны быть открыты"
echo ""

echo "🚀 Следующие шаги:"
echo "1. Если все требования выполнены - приступайте к установке"
echo "2. Если есть проблемы - исправьте их перед установкой"
echo "3. Для установки следуйте инструкции в RASA_STUDIO_INSTALLATION.md"
echo ""

echo "📝 Полезные команды для ручной проверки:"
echo "ssh $USER@$SERVER_IP"
echo "sudo netstat -tlnp | grep -E ':(22|443|30000|30002)'"
echo "sudo ufw status"
echo "systemctl status ssh"
echo "" 