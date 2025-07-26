#!/bin/bash

# インストールスクリプト

# スクリプトのURL
SCRIPT_URL="https://raw.githubusercontent.com/toulhonda/mac-ffmpeg-cli/main/mac-ffmpeg.sh"
# インストール先のパス
INSTALL_DIR="/usr/local/bin"
# インストール後のコマンド名
CMD_NAME="mac-ffmpeg"

echo "mac-ffmpeg-cli をインストールしています..."

# /usr/local/bin が存在するか確認、なければ作成
if [ ! -d "$INSTALL_DIR" ]; then
    echo "インストールディレクトリ ($INSTALL_DIR) が存在しないため、作成します。"
    sudo mkdir -p "$INSTALL_DIR"
    if [ $? -ne 0 ]; then
        echo "ディレクトリの作成に失敗しました。権限を確認してください。"
        exit 1
    fi
fi

# スクリプトをダウンロードしてインストール
echo "スクリプトをダウンロードしています..."
sudo curl -sSL "$SCRIPT_URL" -o "$INSTALL_DIR/$CMD_NAME"

if [ $? -ne 0 ]; then
    echo "スクリプトのダウンロードに失敗しました。URLを確認してください。"
    exit 1
fi

# 実行権限を付与
echo "実行権限を付与しています..."
sudo chmod +x "$INSTALL_DIR/$CMD_NAME"

if [ $? -ne 0 ]; then
    echo "実行権限の付与に失敗しました。"
    exit 1
fi

echo ""
echo "インストールが完了しました！"
echo "ターミナルで 'mac-ffmpeg' と入力してツールを起動できます。"
