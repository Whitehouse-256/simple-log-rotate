#!/bin/bash

ROTATE_FILE_NAME="/var/log/custom.log"
ROTATE_THRESHOLD_MEGS=800

#check if file size is bigger than threshold
filesize=$(du -ms "${ROTATE_FILE_NAME}"|awk '{print$1}')
echo "Size is: $filesize MB!"
if [[ $filesize -lt ${ROTATE_THRESHOLD_MEGS} ]]; then
  echo "File is $filesize MB (< ${ROTATE_THRESHOLD_MEGS}), not rotating yet!"
  exit
fi

i=1

while true; do
  file1="${ROTATE_FILE_NAME}.${i}"
  file2="${ROTATE_FILE_NAME}.${i}.xz"
  echo "${i}. Checking files $file1, $file2"
  if [[ -e "$file1" || -e "$file2" ]]; then
    echo "- One of the file exists! Go to next one..."
  else
    echo "- Files not found! Proceed to move!"
    echo "Running: mv \"${ROTATE_FILE_NAME}\" \"$file1\" && echo \"\" > \"${ROTATE_FILE_NAME}\" && xz \"$file1\"!"
    mv "${ROTATE_FILE_NAME}" "$file1" && echo "" > "${ROTATE_FILE_NAME}" && xz "$file1"
    break
  fi

  let i++
done
