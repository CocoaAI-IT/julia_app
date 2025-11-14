# Python + Julia 開発環境 with Jupyter

Windows 11のWSL2上で動作するPython + Julia統合開発環境です。DockerとVS Code Dev Containersを使用して構築されています。

## 特徴

- **Docker**を用いたコンテナベースの開発環境
- **devcontainer.json**による簡単なコンテナ起動
- **uv**によるPythonパッケージ管理
- **Jupyter Lab/Notebook**でPythonとJuliaの両方を実行可能
- **Julia + Flux**によるMNIST手書き数字分類の実装例

## 必要要件

- Windows 11
- WSL2がインストール済み
- Docker Desktop for Windows（WSL2バックエンド）
- Visual Studio Code
- VS Code拡張機能：
  - Dev Containers (ms-vscode-remote.remote-containers)

## セットアップ手順

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd julia_app
```

### 2. VS Codeでコンテナを開く

1. VS Codeでこのディレクトリを開く
2. コマンドパレット（`Ctrl+Shift+P`）を開く
3. "Dev Containers: Reopen in Container" を選択
4. コンテナのビルドと起動を待つ（初回は10-15分程度かかります）

### 3. 環境の確認

コンテナ内のターミナルで以下を実行して環境を確認：

```bash
# Pythonのバージョン確認
python --version

# Juliaのバージョン確認
julia --version

# uvのバージョン確認
uv --version

# Jupyterの起動
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser
```

## ディレクトリ構造

```
julia_app/
├── .devcontainer/
│   └── devcontainer.json      # Dev Container設定
├── notebooks/
│   └── mnist_classification.ipynb  # MNIST分類のサンプルノートブック
├── Dockerfile                  # コンテナイメージの定義
├── pyproject.toml             # Python依存関係（uv用）
├── setup_julia.jl             # Julia環境のセットアップスクリプト
└── README.md                  # このファイル
```

## Pythonパッケージの管理

このプロジェクトではPythonパッケージの管理に**uv**を使用しています。

### パッケージのインストール

```bash
# pyproject.tomlに定義された依存関係をインストール
uv pip install -e .

# 新しいパッケージを追加
uv pip install <package-name>
```

### パッケージのリスト表示

```bash
uv pip list
```

## Juliaパッケージの管理

### パッケージの追加

```bash
julia -e 'using Pkg; Pkg.add("PackageName")'
```

### インストール済みパッケージ

- IJulia：Jupyter Kernel for Julia
- Flux：機械学習フレームワーク
- MLDatasets：MNISTなどのデータセット
- CUDA：GPU対応（オプション）
- Statistics、Random、Plots

## MNISTサンプルの実行

1. Jupyter Labを起動：
```bash
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser
```

2. ブラウザで `http://localhost:8888` にアクセス

3. `notebooks/mnist_classification.ipynb` を開く

4. カーネルを "Julia 1.10.0" に設定

5. セルを順番に実行（`Shift+Enter`）

### MNISTノートブックの内容

- MNISTデータセットの読み込み
- データの前処理と可視化
- 3層ニューラルネットワークの構築
- モデルの訓練（10エポック）
- 訓練過程の可視化
- モデルの評価（精度計算、混同行列）
- 予測結果の可視化

期待される精度：約97-98%

## トラブルシューティング

### コンテナのビルドに失敗する

- Docker Desktopが起動していることを確認
- WSL2のメモリ割り当てを増やす（.wslconfigで設定）

### Juliaパッケージのインストールに時間がかかる

- 初回のプリコンパイルには時間がかかります（10-20分程度）
- `setup_julia.jl`が正常に実行されるまで待つ

### Jupyter Kernelが表示されない

コンテナ内で以下を実行：

```bash
julia setup_julia.jl
```

### GPUが使用できない

- CUDAパッケージはオプションです
- CPU環境でも問題なく動作します

## 開発のヒント

### Python環境

```bash
# インタラクティブシェル
python

# スクリプトの実行
python script.py
```

### Julia環境

```bash
# Julia REPL
julia

# スクリプトの実行
julia script.jl
```

### Jupyter

- PythonカーネルとJuliaカーネルの両方が使用可能
- ノートブックごとにカーネルを選択可能
- セルの実行：`Shift+Enter`
- 新しいセルの追加：`B`（下）、`A`（上）

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。

## 参考リンク

- [Julia公式サイト](https://julialang.org/)
- [Flux.jl](https://fluxml.ai/)
- [uv - Python package manager](https://github.com/astral-sh/uv)
- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
