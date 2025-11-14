# Python + Julia + uv開発環境
FROM python:3.11-slim

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    UV_SYSTEM_PYTHON=1 \
    JULIA_VERSION=1.10.0

# 基本パッケージとJuliaの依存関係をインストール
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# uvのインストール
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:${PATH}"

# Juliaのインストール
RUN wget -q --show-progress https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar -xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    mv julia-${JULIA_VERSION} /usr/local/julia && \
    rm julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    ln -s /usr/local/julia/bin/julia /usr/local/bin/julia

# 作業ディレクトリの設定
WORKDIR /workspace

# pyproject.tomlをコピーしてPythonパッケージをインストール
COPY pyproject.toml ./
RUN uv pip install -e .

# Juliaのセットアップスクリプトをコピーして実行
COPY setup_julia.jl ./
RUN julia setup_julia.jl

# コンテナ起動時のデフォルトコマンド
CMD ["/bin/bash"]
