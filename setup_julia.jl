#!/usr/bin/env julia

using Pkg

println("🔧 Setting up Julia packages...")

# パッケージのインストール
packages = [
    "IJulia",      # Jupyter Kernel for Julia
    "Flux",        # Machine Learning library
    "MLDatasets",  # MNIST dataset
    "CUDA",        # GPU support (optional)
    "Statistics",  # Statistical functions
    "Random",      # Random number generation
    "Plots",       # Plotting
]

println("📦 Installing packages: ", join(packages, ", "))
Pkg.add(packages)

# IJuliaカーネルのビルド
println("🔨 Building IJulia kernel...")
Pkg.build("IJulia")

# パッケージのプリコンパイル
println("⚡ Precompiling packages...")
Pkg.precompile()

println("✅ Julia setup completed successfully!")
