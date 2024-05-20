# This is an auto generated Dockerfile for ros:ros-base
# generated from docker_images_ros2/create_ros_image.Dockerfile.em
# FROM ros:iron-ros-core-jammy
FROM ros:kinetic
# # install bootstrap tools
# RUN apt-get update && apt-get install --no-install-recommends -y \
#     build-essential \
#     git \
#     python3-colcon-common-extensions \
#     python3-colcon-mixin \
#     python3-rosdep \
#     python3-vcstool \
#     && rm -rf /var/lib/apt/lists/*

# # bootstrap rosdep
# RUN rosdep init && \
#   rosdep update --rosdistro $ROS_DISTRO

# # setup colcon mixin and metadata
# RUN colcon mixin add default \
#       https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
#     colcon mixin update && \
#     colcon metadata add default \
#       https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
#     colcon metadata update

# # install ros2 packages
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ros-iron-ros-base=0.10.0-3* \
#     && rm -rf /var/lib/apt/lists/*

# MAVROS INSTALLATION
ENV DEBIAN_FRONTEND=noninteractive

ARG STARTDELAY=5
ENV STARTDELAY=$STARTDELAY

# Install MAVROS and some other dependencies for later
RUN apt-get update && apt-get install -y ros-kinetic-mavros ros-kinetic-mavros-extras ros-kinetic-mavros-msgs vim wget screen

# Dependency from https://github.com/mavlink/mavros/blob/master/mavros/README.md
RUN wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
RUN chmod +x install_geographiclib_datasets.sh
RUN ./install_geographiclib_datasets.sh

# Fix the broken apm_config.yaml
COPY apm_config.yaml /opt/ros/kinetic/share/mavros/launch/apm_config.yaml

# MAVLink Input
EXPOSE 5760

# Envs
ENV FCUURL=tcp://localhost:5760

# Finally the command
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh ${FCUURL}