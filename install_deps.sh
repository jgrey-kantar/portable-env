#!/bin/bash

# Parse the JSON formatted configuration file
apt_deps=$(jq -r '.dependencies[] | select(.installer == "apt") | .versions[]' dependencies.json)
pyenv_deps=$(jq -r '.dependencies[] | select(.installer == "pyenv") | .versions[]' dependencies.json)
phpenv_deps=$(jq -r '.dependencies[] | select(.installer == "phpenv") | .versions[]' dependencies.json)
npm_deps=$(jq -r '.dependencies[] | select(.installer == "npm") | .name' dependencies.json)


# Install pyenv Python Package Manager
if [ ! -x "$(command -v pyenv)" ]; then
  # Clone pyenv from Github
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv

  # Add pyenv to the PATH and set up the shell integration
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc

  # Reload the .bashrc file
  source ~/.bashrc

  # Configure and install Python with pyenv
  cd ~/.pyenv && src/configure && make -C src
fi


echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc


# Install apt dependencies
if [ -n "$apt_deps" ]; then
  apt-get update
  apt-get install -y $apt_deps
fi

# Install pyenv dependencies
if [ -n "$pyenv_deps" ]; then
  for pyenv_dep in $pyenv_deps
  do
    pyenv install $pyenv_dep
  done
fi

# Install phpenv dependencies
# if [ -n "$phpenv_deps" ]; then
#   for phpenv_dep in $phpenv_deps
#   do
#     phpenv install $phpenv_dep
#   done
# fi
echo 'Skipping phpenv - Further configuration needed'

# Install npm dependencies
if [ -n "$npm_deps" ]; then
  npm install -g $npm_deps
fi

# Install dpkg dependencies
# if [ -n "$dpkg_urls" ]; then
#   num_dpkg_deps=${#dpkg_urls[@]}
#   for i in $(seq 0 $((${#dpkg_urls[@]} - 1))); do
#     echo "Installing dpkg dependency [$((i + 1))/$num_dpkg_deps]: ${dpkg_names[i]}"
#     echo "Source URL: ${dpkg_urls[i]}"
#     file_name=$(basename "${dpkg_urls[i]}")
#     echo "Downloaded file: $file_name"
#     curl -o "$file_name" "${dpkg_urls[i]}"
#     dpkg --install "$file_name"
#   done
# fi