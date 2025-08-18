#!/bin/bash

# dir=instead-cli-v1.7-a0f1e04
# mkdir -p $dir

# curl -L -o release.zip https://github.com/gretmn102/instead-cli/releases/download/v1.7-a0f1e04/instead-cli-v1.7-a0f1e04.zip

# if [ $? -ne 0 ]; then
#   echo "Ошибка при скачивании файла."
#   exit 1
# fi

echo "Распаковка release.zip..."
unzip -d node_modules/.bin release.zip

if [ $? -ne 0 ]; then
  echo "Ошибка при распаковке файла."
  exit 1
fi

# rm release.zip
