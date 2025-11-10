#!/bin/bash
set -e

echo "🚀 Starting post-create setup..."

# uvでPythonパッケージをインストール
if [ -f pyproject.toml ]; then
    echo "📦 Installing Python packages with uv..."
    uv pip install -e .
fi

# Juliaのセットアップ
if [ -f setup_julia.jl ]; then
    echo "🔧 Setting up Julia packages..."
    julia setup_julia.jl
fi

echo "✅ Post-create setup completed!"
