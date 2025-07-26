# README.md

# mac-ffmpeg-cli

`mac-ffmpeg-cli` は、macOSユーザー向けに設計された、FFmpegをより簡単に利用するためのコマンドラインツールです。音声ファイルをMP4形式に変換する一般的なタスクを、シンプルなメニュー操作で実行できます。

## ✨ 特徴 (Features)

- **メニュー形式の簡単操作**: 番号を選択するだけで、やりたい操作を簡単に実行できます。
- **個別・一括変換**: 1つのファイルの変換から、ディレクトリ内の全ファイルの変換まで対応。
- **Homebrew連携**: スクリプト内から直接Homebrewのアップデートが可能です。
- **進捗表示**: FFmpegの変換状況をリアルタイムで確認できます。
- **軽量なシェルスクリプト**: Pythonなどの実行環境を別途インストールする必要がなく、macOSの標準的な環境で動作します。

## ⚙️ 前提条件 (Prerequisites)

本ツールを使用するには、お使いのmacOSに以下のソフトウェアがインストールされている必要があります。

- **Homebrew**: macOS用のパッケージマネージャー。
- **FFmpeg**: Homebrew経由でインストールされた動画・音声変換ツール。

もしインストールされていない場合は、ターミナルで以下のコマンドを実行してください。

```bash
# Homebrewのインストール (未導入の場合)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# FFmpegのインストール
brew install ffmpeg
```

## 🚀 インストール (Installation)

### ローカルでの使用

リポジトリをクローンまたはダウンロードした後、ターミナルでスクリプトに実行権限を与えて実行します。

```bash
# 実行権限を付与
chmod +x mac-ffmpeg.sh

# スクリプトを実行
./mac-ffmpeg.sh
```

### グローバルインストール (推奨)

システムのどこからでも `mac-ffmpeg` コマンドとしてツールを呼び出せるように、ワンライナーでのインストールを推奨します。

**インストールコマンド:**
```bash
curl -sSL https://raw.githubusercontent.com/toulhonda/mac-ffmpeg-cli/main/install.sh | bash
```

**手動でのインストール:**

1.  **リポジトリをクローンまたはダウンロードします。**
    ```bash
    git clone https://github.com/toulhonda/mac-ffmpeg-cli.git
    cd mac-ffmpeg-cli
    ```
2.  **スクリプトに実行権限を付与します。**
    ```bash
    chmod +x mac-ffmpeg.sh
    ```
3.  **スクリプトを `/usr/local/bin` に移動し、リネームします。**
    `/usr/local/bin` は、macOSでユーザーがインストールしたコマンドラインツールを配置する標準的なディレクトリです。
    ```bash
    sudo mv mac-ffmpeg.sh /usr/local/bin/mac-ffmpeg
    ```
    *(この操作には管理者パスワードの入力が必要です)*

### アンインストール

`mac-ffmpeg` をシステムから削除するには、以下のコマンドを実行します。

```bash
sudo rm /usr/local/bin/mac-ffmpeg
```
*(この操作には管理者パスワードの入力が必要です)*

## 使い方 (Usage)

スクリプトを起動すると、以下のメニューが表示されます。

```
----- 音声ファイルMP4変換ツール (Shell版) -----
1. Homebrew をアップデート
2. 個別ファイルを MP4 に変換
3. ディレクトリ内のファイルを一括変換
4. 終了
-----------------------------------
選択してください (1-4):
```

- **1. Homebrew をアップデート**: `brew update && brew upgrade` を実行し、Homebrewパッケージを最新の状態に保ちます。
- **2. 個別ファイルを MP4 に変換**: 音声ファイル（`.wav`, `.mp3`, `.m4a`）のパスを一つ入力し、黒画面のMP4動画に変換します。
- **3. ディレクトリ内のファイルを一括変換**: 指定したディレクトリ内にある全ての対応音声ファイルを、一括でMP4に変換します。
- **4. 終了**: スクリプトを終了します。
