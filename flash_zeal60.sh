#!/bin/bash

printf "Making the {$1} Zeal60 keymap..."

printf "\n\n============ DIFF =============\n"
git diff

printf "\n\n========== BUILDING ===========\n"
cd keyboards/zeal60/ && make $1 && cd ../../


flash_keymap()
{
    printf "\n\n========== FLASHING ===========\n"
    printf "You have 5 seconds to put your keyboard into programming mode before flashing.\n\n"
    sleep 5
    dfu-programmer atmega32u4 erase --force
    dfu-programmer atmega32u4 flash zeal60_tusing.hex
    dfu-programmer atmega32u4 reset

    printf "\n\n==========  KEYMAP  ============\n"
    echo "Attempted to flash keymap:"
    cat keyboards/zeal60/keymaps/tusing/keymap.c
}


read -p "Flash this keymap? (y/n)" choice
case "$choice" in
    y|Y ) flash_keymap;;
    n|N ) echo "Aborting flash." && exit;;
    * ) echo "Invalid response." && exit;;
esac
