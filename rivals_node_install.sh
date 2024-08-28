#!/bin/bash
tput reset
tput civis

echo -e "\e[33m"
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
    echo "3. Создать screen сессию (Create screen session)"
    echo "4. Запустить ноду (Start Node)"
    echo "5. Удалить сессию Rivals (Close Rival session)"
    echo "6. Обновить Rivals (Update)"
    echo "7. Изменить кошелек (Change wallet)"
    echo "8. Поменять потребляемое место на диске (Change the disk usage)"
    echo "9. Инфо о ноде (Node info)"
    echo "10. Удалить Rivals (Delete Node)"
    echo "11. Выход (Exit)"
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
                echo ""
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
                echo ""
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
                echo ""
                exit 1
            fi

            if sudo apt install -y nodejs; then
                sleep 1
                echo -e "Установка Node.js (installation Node.js): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Установка Node.js (installation Node.js): Ошибка (\e[31mError\e[0m)"
                echo ""
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
                echo ""
                exit 1
            fi

            # Applying disk fix
            echo "Применяем фикс на диск (Applying disk fix)..."
            sleep 1
            FILE="/usr/lib/node_modules/rivalz-node-cli/node_modules/systeminformation/lib/filesystem.js"; then

            # Function to find the correct file path
            find_file_path() {
            local search_path="$1"
            find "$search_path" -type f -name "filesystem.js" 2>/dev/null | grep "systeminformation/lib/filesystem.js" | head -n 1
            }

            # Check if the file exists
            if [ ! -f "$FILE" ]; then
            echo "File not found at $FILE. Attempting to locate it..."
            FILE=$(find_file_path "/usr/lib")

            if [ -z "$FILE" ]; then
                FILE=$(find_file_path "/usr/local/lib")
            fi

            if [ -z "$FILE" ]; then
                FILE=$(find_file_path "/opt")
            fi

            if [ -z "$FILE" ]; then
                # Adding check for ~/.nvm path
                FILE=$(find_file_path "$HOME/.nvm")
            fi

            if [ -z "$FILE" ]; then
                echo "Error: filesystem.js not found. Make sure npm is installed and the file path is correct."
                exit 1
            fi

            echo "File found at $FILE"
            fi

            # Create a temporary file
            TMP_FILE=$(mktemp)

            # Define the original line and the replacement line
            ORIGINAL_LINE="devices = outJSON.blockdevices.filter(item => { return (item.type === 'disk') && item.size > 0 && (item.model !== null || (item.mountpoint === null && item.label === null && item.fstype === null && item.parttype === null && item.path && item.path.indexOf('/ram') !== 0 && item.path.indexOf('/loop') !== 0 && item['disc-max'] && item['disc-max'] !== 0)); });"
            NEW_LINE="devices = outJSON.blockdevices.filter(item => { return (item.type === 'disk') && item.size > 0 }).sort((a, b) => b.size - a.size);"

            # Read through the file line by line
            while IFS= read -r line
            do
            if [[ "$line" == *"$ORIGINAL_LINE"* ]]; then
                echo "$NEW_LINE" >> "$TMP_FILE"
            else
                echo "$line" >> "$TMP_FILE"
            fi
            done < "$FILE"

            # Replace the original file with the modified one
            if mv "$TMP_FILE" "$FILE"; then
                echo -e "Применяем фикс на диск (Applying disk fix): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Применяем фикс на диск (Applying disk fix): Ошибка (\e[31mError\e[0m)"
                echo ""
                exit 1
            fi

            echo ""
            echo -e "\e[32m----------- SUCCESS!!! ----------\e[0m"
            echo -e "Rivalz Node has been successfully installed!"
            echo ""
            echo -e "\n Подпишись на мой канал Beloglazov invest, \n чтобы быть в курсе самых актуальных нод и активностей \n https://t.me/beloglazovinvest\n"
            ;;
        3)
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
                echo ""
                exit 1
            fi
            ;;
        4)
            #start node
            echo "Запускаем ноду. (Starting the node)..."
            sleep 1
            screen -S rivalz_node -X stuff "rivalz run$(echo -ne '\r')"
            ;;
        5)
            # Closing screen session 'rivalz_node'...
            echo "Удаляем сессию. (Closing screen session 'rivalz_node')..."
            screen -S rivalz_node -X quit; then
                sleep 1
                echo -e "Screen сессия удалена (Screen session closed): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Screen сессия удалена (Screen session closed): Ошибка (\e[31mError\e[0m)"
                echo ""
                exit 1
            fi
            ;;
        6)
            # Update Rivals
            echo "Обновление ноды (Updating Rivals)..."
	        if rivalz update-version; then
                echo -e "Обновление ноды (Updating Rivals): Успешно (\e[32mSuccess\e[0m)"
                echo ""
            else
                echo -e "Обновление ноды (Updating Rivals): Ошибка (\e[31mError\e[0m)"
                echo ""
                exit 1
            fi
            ;;
        7)
            # change-wallet
            rivalz change-wallet
            echo ""
            ;;
        8)
            # change-hardware-config
            rivalz change-hardware-config
            echo ""
            ;;
        9)
            # node info
            rivalz info
            echo ""
            ;;
        10)
            # Remove soft and node
            # 1. Removing Node.js
            echo "Удаляем Node.js. (Removing Node.js)..."
            if sudo apt remove --purge -y nodejs; then
                sleep 1
                echo -e "Node.js. удален (Node.js Removed): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Node.js. удален (Node.js Removed): Ошибка (\e[31mError\e[0m)"
                echo ""
                exit 1
            fi

            # Removing Rivalz Node CLI...
            echo "Удаление ноды. (Removing Rivalz Node CLI)..."
            if sudo npm uninstall -g rivalz-node-cli; then
                sleep 1
                echo -e "Удаление ноды. (Removing Rivalz Node CLI): Успешно (\e[32mSuccess\e[0m)"
                echo ""
                sleep 1
            else
                echo -e "Удаление ноды. (Removing Rivalz Node CLI): Ошибка (\e[31mError\e[0m)"
                echo ""
                exit 1
            fi
            ;;
        11)
            # Stop script and exit
            echo -e "\e[31mСкрипт остановлен (Script stopped)\e[0m"
            echo ""
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
