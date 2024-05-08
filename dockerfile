# 使用官方的 Ubuntu 20.04 LTS 基础镜像
FROM ubuntu:20.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 更新 Ubuntu 软件包索引
RUN apt-get update -y


RUN apt-get install -y cmake make
# 安装依赖
RUN apt-get update -y && apt-get install -y wget

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update -y && \
    apt-get install -y gcc-9 g++-9 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 && \
    apt-get install -y python3-pip



# 安装 GCC 9.3.0
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update -y && \
    apt-get install -y gcc-9 g++-9 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9

# 安装 Eigen
RUN apt-get install -y libeigen3-dev
# # 下载和添加 Intel OpenVINO 的 GPG 密钥
# COPY intel-openvino-key /tmp/intel-openvino-key
# RUN apt-key add /tmp/intel-openvino-key && \
#     rm /tmp/intel-openvino-key
# 下载并添加 Intel OpenVINO 的 GPG 密钥
# RUN wget https://apt.repos.intel.com/openvino/2021/GPG-PUB-KEY-INTEL-OPENVINO-2021 -O - | apt-key add -

# # 添加 Intel OpenVINO 存储库
# RUN echo "deb https://apt.repos.intel.com/openvino/2021 all main" | tee /etc/apt/sources.list.d/intel-openvino-2021.list && \
#     apt-get update -y && \
#     apt-get install -y intel-openvino-dev-ubuntu20
# # 安装 OpenVINO 2021.4
# # 此处需要添加 OpenVINO 2021.4 的安装步骤，可能包括：
# # 添加 Intel 存储库的 GPG 密钥
# # 添加 Intel 存储库
# # 安装 OpenVINO 工具套件
# # 注意：以下步骤可能需要根据 OpenVINO 2021.4 的具体安装指南进行调整
RUN wget https://apt.repos.intel.com/openvino/2021/GPG-PUB-KEY-INTEL-OPENVINO-2021 -O - | apt-key add - && \
    echo "deb https://apt.repos.intel.com/openvino/2021 all main" | tee /etc/apt/sources.list.d/intel-openvino-2021.list && \
    apt-get update -y && \
    apt-get install -y intel-openvino-dev-ubuntu20
# RUN echo "deb https://apt.repos.intel.com/openvino/2021 all main" | tee /etc/apt/sources.list.d/intel-openvino-2021.list && \
#     apt-get update -y && \
#     apt-get install -y intel-openvino-dev-ubuntu20

# 安装 OpenCV（OpenVINO 2021.4 自带 OpenCV 4.5.0）
# 如果需要单独安装 OpenCV，可以使用以下命令：
# RUN pip3 install opencv-python-headless

# 安装 fmt
RUN pip3 install --upgrade pip && \
    pip3 install git+https://github.com/fmtlib/fmt.git

# 安装 glog
RUN apt-get install -y libglog-dev

# 安装 Ceres Solver
RUN apt-get install -y cmake && \
    git clone -b 2.1.0 https://github.com/ceres-solver/ceres-solver.git /ceres-solver && \
    cd /ceres-solver && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install

# 安装 yaml-cpp
RUN apt-get install -y libyaml-cpp-dev

# 安装 matplotlib-cpp
# 由于 matplotlib-cpp 不是通过 pip 安装的，你需要克隆其 GitHub 仓库并编译安装
RUN git clone https://github.com/lava/matplotlib-cpp.git /matplotlib-cpp && \
    cd /matplotlib-cpp && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# 设置工作目录
WORKDIR /TUP-InfantryVision-2022-main

# 将当前目录下的文件复制到工作目录下
COPY . /TUP-InfantryVision-2022-main

# 运行你的应用程序或命令
# 这里需要替换成你的应用程序的启动命令
CMD ["bash", "-c", "source /opt/intel/openvino/bin/setupvars.sh && build/Infantry_Vision"]

Run mkdir build && \
    cd build && \
    cmake .. && \
    make -j8
CMD ["./build/Infantry_Vision"]
