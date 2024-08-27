#!/bin/bash
tput reset
tput civis

echo -e "\e[40m\e[32m"
echo -e '----------_____--------------------_____----------------_____----------'
echo -e '---------/\----\------------------/\----\--------------/\----\---------'
echo -e '--------/::\____\----------------/::\----\------------/::\----\--------'
echo -e '-------/:::/----/---------------/::::\----\-----------\:::\----\-------'
echo -e '------/:::/----/---------------/::::::\----\-----------\:::\----\------'
echo -e '-----/:::/----/---------------/:::/\:::\----\-----------\:::\----\-----'
echo -e '----/:::/____/---------------/:::/__\:::\----\-----------\:::\----\----'
echo -e '----|::|----|---------------/::::\---\:::\----\----------/::::\----\---'
echo -e '----|::|----|-----_____----/::::::\---\:::\----\--------/::::::\----\--'
echo -e '----|::|----|----/\----\--/:::/\:::\---\:::\----\------/:::/\:::\----\-'
echo -e '----|::|----|---/::\____\/:::/--\:::\---\:::\____\----/:::/--\:::\____\'
echo -e '----|::|----|--/:::/----/\::/----\:::\--/:::/----/---/:::/----\::/----/'
echo -e '----|::|----|-/:::/----/--\/____/-\:::\/:::/----/---/:::/----/-\/____/-'
echo -e '----|::|____|/:::/----/------------\::::::/----/---/:::/----/----------'
echo -e '----|:::::::::::/----/--------------\::::/----/---/:::/----/-----------'
echo -e '----\::::::::::/____/---------------/:::/----/----\::/----/------------'
echo -e '-----~~~~~~~~~~--------------------/:::/----/------\/____/-------------'
echo -e '----------------------------------/:::/----/---------------------------'
echo -e '---------------------------------/:::/----/----------------------------'
echo -e '---------------------------------\::/----/-----------------------------'
echo -e '----------------------------------\/____/------------------------------'
echo -e '-----------------------------------------------------------------------'
echo -e '\e[0m'

echo -e "\n Подпишись на мой канал Beloglazov invest, \n чтобы быть в курсе самых актуальных нод и активностей \n https://t.me/beloglazovinvest\n"

sleep 2

while true; do
    echo "1. Подготовка у установке Rivals (Preparation)"
    echo "2. Установка Rivals (Install)"
    echo "3. Обновить Rivals (Update)"
    echo "4. Обновить конфигурацию (Configuration update)"
    echo "5. Изменить кошелек (Change wallet)"
    echo "6. Поменять потребляемое место на диске (Change the disk usage)"
    echo "7. Инфо о ноде (Node info)"
    echo "8. Выход (Exit)"
    echo ""
    read -p "Выберите опцию (Select option): " option

    case $option in
        1)
            # update packages
            echo "Обновление пакетов (updating packages) ... "
            sleep 1
            if sudo apt update && sudo apt upgrade -y; then
                sleep 1
                echo -e "Обновление пакетов (updating packages): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Обновление пакетов (updating packages): Ошибка (\e[31mError\e[0m)"
                exit 1
            fi

            # Installing screen
            echo "Устанавливаем утилиту screen (Installing screen)..."
            sleep 1
            if sudo apt-get install -y screen; then
                sleep 1
                echo -e "Установка утилиы screen (Installation screen): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Установка утилиы screen (Installation screen): Ошибка (\e[31mError\e[0m)"
                exit 1
            fi

            # Installing Node.js
            echo "Устанавливаем Node.js (Installing Node.js)..."
            sleep 1
            if curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -; then
                sleep 1
                echo -e "Node.js скрипт установки скачан (Node.js setup script downloaded): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Node.js скрипт установки скачан (Node.js setup script downloaded): Ошибка (\e[31mError\e[0m)"
                exit 1
            fi

            if sudo apt install -y nodejs; then
                sleep 1
                echo -e "Установка Node.js (installation Node.js): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Установка Node.js (installation Node.js): Ошибка (\e[31mError\e[0m)"
                exit 1
            fi
            ;;
        2)
            # Installing Rivalz Node CLI
            echo "Устанавливаем ноду через npm (Installing Rivalz Node CLI)..."
            sleep 1
            if sudo npm i -g rivalz-node-cli; then
                sleep 1
                echo -e "Установка ноды через npm (Installation Rivalz Node CLI): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Установка ноды через npm (Installation Rivalz Node CLI): Ошибка (\e[31mError\e[0m)"
                exit 1
            fi

            # Applying disk fix
            echo "Применяем фикс на диск (Applying disk fix)..."
            sleep 1
            if . <(wget -qO- https://raw.githubusercontent.com/Alexjptz/Rivals-node/main/diskfix.sh); then
                sleep 1
                echo -e "Применяем фикс на диск (Applying disk fix): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Применяем фикс на диск (Applying disk fix): Ошибка (\e[31mError\e[0m)"
                exit 1
            fi

            # Creating screen session
            echo "Создаем screen сессию (Creating screen session)..."
            sleep 1
            if screen -dmS rivalz_node; then
                sleep 1
                echo -e "Создана screen сессия (Screen session created): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Создана screen сессия (Screen session created): Ошибка (\e[31mError\e[0m)"
                exit 1
            fi

            # Starting Rivalz Node
            echo "Запускаем ноду в screen сессии (Starting Rivalz Node)..."
            sleep 1
            if screen -S rivalz_node -X stuff "rivalz run\n"; then
                sleep 1
                echo -e "Нода в screen сессии запущена (Rivalz Node Started): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Нода в screen сессии запущена (Rivalz Node Started): Ошибка (\e[31mError\e[0m)"
                exit 1
            fi

            echo ""
            echo -e "\e[32m----------------- SUCCESS!!! ----------------\e[0m"
            echo -e "Rivalz Node has been successfully installed and started!"
            echo ""
            echo -e "\n Подпишись на мой канал Beloglazov invest, \n чтобы быть в курсе самых актуальных нод и активностей \n https://t.me/beloglazovinvest\n"
            ;;
        3)
            # Update Rivals
            echo "Обновление ноды (Updating Rivals)..."
	        if rivalz update-version; then
                echo -e "Обновление ноды (Updating Rivals): Успешно (\e[32mSuccess\e[0m)"
            else
                echo -e "Обновление ноды (Updating Rivals): Ошибка (\e[31mError\e[0m)"
                exit 1
            fi
            ;;
        4)
            # update configuration
            rivals update
            ;;
        5)
            # change-wallet
            rivalz change-wallet
            ;;
        6)
            # change-hardware-config
            rivalz change-hardware-config
            ;;
        7)
            # node info
            rivalz info
            ;;
        8)
            # Stop script and exit
            echo -e "\e[31mСкрипт остановлен (Script stopped)\e[0m"
            exit 0
            ;;
        *)
            # incorrect options
            echo ""
            echo -e "\e[31mНеверная опция\e[0m. Пожалуйста, выберите из тех, что есть."
            echo ""
            echo -e "\e[31mInvalid option.\e[0m Please choose from the available options."
            echo ""
            ;;
    esac
done
