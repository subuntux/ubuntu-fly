#!/bin/bash

pkg install termux-api -y

termux-setup-storage

termux-wake-lock

echo "[!] You need Termux-API"

select_option() {
    echo "Welcome by Ubuntu-Fly"
    echo "[1] Start Setup (Needed Programms)"
    echo "[2] Download Ubuntu-Fly"
    echo "[3] Setup Ubuntu-Fly"
    echo "[4] Remove this Script"
    echo "[0] Exit"
    
    read -p "select:~#| " option1
    
    case $option1 in
        0)
            exit 0
            ;;
        1)
            termux-notification --title "Installing needed Programms" --content "Termux is installing needed Programms" --priority high
            pkg install git -y 
            pkg install proot-distro -y 
            pkg install wget -y 
            pkg install zip -y 
            pkg update -y 
            termux-notification --title "Installation Finisg" --content "The needed Programms are Installed" --priority high
            ;;
        2)
            cd $HOME
            termux-notification --title "Download Ubuntu-Fly" --content "This can take a while" --priority high
            wget https://raw.githubusercontent.com/subuntux/ubuntu-fly/main/releases/download/v.1.0/ubuntu-fly.zip 
            mkdir -p .ubuntu-fly/files 
            mv ubuntu-fly.zip .ubuntu-fly/files
            cd .ubuntu-fly/files
            unzip ubuntu-fly.zip 
            rm ubuntu-fly.zip 
            cd $HOME
            termux-notification --title "Download Finish" --content "Download needed Files finish" --priority high 
            ;;
        3)
            setup_fly
            ;;
        4)
            rm -r -f .ubuntu-fly/
            rm ub-fl.sh 
            ;;
        *)
            echo "WARNING, you have use an invalid Option"
            termux-notification --title "ERROR" --content "You have use an Invalid Option" --priority high
            termux-tts-speak "Invalid Option"
            ;;
    esac
}

setup_fly() {
    echo "Use on from this Installing Options"
    echo "[1] Install with Script"
    echo "[2] Install with Backup"
    echo "[0] Exit"
    
    read -p "select~#| " option2
    
    case $option2 in 
        0)
            exit 0
            ;;
        1)
            termux-notification --title "Start Setup" --content "Starting Setup with Script" --priority high
            cd $HOME
            cp .ubuntu-fly/files/ubuntu-fly.sh .
            mv ubuntu-fly.sh $PREFIX/etc/proot-distro/
            pd i ubuntu-fly 
            termux-notification --title "Setup Finish" --content "The Setup is now Finsih" --priority high
            ;;
        2)
            termux-notification --title "Start Setup" --content "Start Setup with Backup" --priority high
            cd $HOME
            mv .ubuntu-fly/files/ubuntu-fly.tar.gz 
            pd restore ubuntu-fly.tar.gz 
            rm ubuntu-fly.tar.gz 
            termux-notification --title "Setup Finish" --content "Termux have Setup the Backup" --priority high
            ;;
        *)
            echo "WARNING, you have use an invalid Option"
            termux-notification --title "ERROR" --content "You have use an Invalid Option" --priority high
            termux-tts-speak "Invalid Option"
            ;;
    esac
}

main() {
    while true; do
        select_option
        echo ""
    done
}

main