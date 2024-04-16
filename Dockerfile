# Используем базовый образ Ubuntu 22.04
FROM ubuntu:22.04

# Обновляем пакеты и устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Добавляем ключ репозитория ROS 2
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# Добавляем репозиторий ROS 2
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# Обновляем список пакетов и устанавливаем ROS 2
RUN apt-get update && apt-get install -y \
    ros-foxy-desktop \
    && rm -rf /var/lib/apt/lists/*

# Инициализируем окружение ROS 2
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc

# Устанавливаем пакеты MAVROS
RUN apt-get update && apt-get install -y \
    ros-foxy-mavros \
    ros-foxy-mavros-msgs \
    && rm -rf /var/lib/apt/lists/*

# Инициализируем окружение MAVROS
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc

# Устанавливаем другие необходимые пакеты или выполняем другие настройки, если это необходимо

# Опционально: копируем исходные файлы вашего приложения в образ Docker и устанавливаем их, если это необходимо
# COPY ваш_приложение /путь_в_образе

# Опционально: указываем команду по умолчанию, которая будет запущена при запуске контейнера
# CMD [ "bash" ]

RUN echo «it works»

