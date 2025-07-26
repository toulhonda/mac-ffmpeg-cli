#!/bin/bash

# スプラッシュスクリーンの表示
display_splash() {
    cat <<'EOF'
███╗   ███╗ █████╗  ██████╗       ███████╗███████╗███╗   ███╗██████╗ ███████╗ ██████╗ 
████╗ ████║██╔══██╗██╔════╝       ██╔════╝██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝ 
██╔████╔██║███████║██║            █████╗  █████╗  ██╔████╔██║██████╔╝█████╗  ██║  ███╗
██║╚██╔╝██║██╔══██║██║    ████    ██╔══╝  ██╔══╝  ██║╚██╔╝██║██╔═╝ ██╔══╝  ██║   ██║
██║ ╚═╝ ██║██║  ██║╚██████╗       ██║     ██║     ██║ ╚═╝ ██║██║     ███████╗╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝       ╚═╝     ╚═╝     ╚═╝     ╚═╝╚═╝     ╚══════╝ ╚═════╝ 

 ██████╗██╗     ██╗
██╔════╝██║     ██║
██║     ██║     ██║
██║     ██║     ██║
╚██████╗███████╗██║
 ╚═════╝╚══════╝╚═╝

                    🍎 macOS FFmpeg Command Line Interface 🎬
                              Version 2025.07.26
                    
    ─────────────────────────────────────────────────────────────────────
    
           🎥 Professional video/audio processing and conversion
           🔧 Advanced encoding with customizable parameters  
           ⚡ Hardware-accelerated processing on Apple Silicon
           📊 Batch processing and automation support
    
    ─────────────────────────────────────────────────────────────────────
    
                    Ready to process! Enter command or file path...
EOF
    sleep 2
}

# メニューの表示と選択
display_menu() {
    echo "----- 音声ファイルMP4変換ツール (Shell版) -----"
    echo "1. Homebrew をアップデート"
    echo "2. 個別ファイルを MP4 に変換"
    echo "3. ディレクトリ内のファイルを一括変換"
    echo "4. 終了"
    echo "-----------------------------------"
    read -p "選択してください (1-4): " choice
    echo "" # 改行
    return $choice
}

# Homebrewのアップデート
handle_brew_update() {
    echo "Homebrew をアップデートしています..."
    if ! command -v brew &> /dev/null; then
        echo "'brew' コマンドが見つかりません。Homebrewがインストールされているか確認してください。"
        return
    fi

    brew update && brew upgrade
    local exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "Homebrew のアップデートが完了しました。"
    else
        echo "Homebrew のアップデート中にエラーが発生しました。"
    fi
}

# FFmpegコマンドの実行
run_ffmpeg_command() {
    local input_file="$1"
    local output_file="${input_file%.*}.mp4"

    if ! command -v ffmpeg &> /dev/null; then
        echo "'ffmpeg' コマンドが見つかりません。FFmpegがインストールされているか確認してください。"
        return 1
    fi

    echo "コマンド実行: ffmpeg -y -f lavfi -i color=black:s=1280x720:r=25 -i \"$input_file\" -shortest -c:v libx264 -c:a aac -b:a 192k -pix_fmt yuv420p -v quiet -stats \"$output_file\""
    
    # FFmpegコマンドを実行し、進捗を表示する
    # -v quiet -stats を使うと、進捗がstderrに出力される
    ffmpeg -y -f lavfi -i color=black:s=1280x720:r=25 -i "$input_file" -shortest -c:v libx264 -c:a aac -b:a 192k -pix_fmt yuv420p -v quiet -stats "$output_file"
    local exit_code=$?
    
    # プログレス表示の後に改行を入れる
    echo ""

    if [ $exit_code -eq 0 ]; then
        echo "ファイルの変換が成功しました: $output_file"
        return 0
    else
        echo "ファイルの変換に失敗しました: $input_file"
        echo "エラーの詳細は上記の出力を確認してください。"
        return 1
    fi
}

# 個別ファイルの変換
handle_single_file_conversion() {
    while true; do
        read -p "変換したい音声ファイルのパスを入力してください (終了する場合は 'q' を入力): " input_file_path
        if [[ "$input_file_path" == "q" ]]; then
            break
        fi

        if [ ! -f "$input_file_path" ]; then
            echo "指定されたファイルが見つかりません。再入力してください。"
            continue
        fi

        ext="${input_file_path##*.}"
        if [[ ! "$ext" =~ ^(wav|mp3|m4a)$ ]]; then
            echo "対応していないファイル形式です。WAV, MP3, M4A ファイルのみ対応しています。"
            continue
        fi

        run_ffmpeg_command "$input_file_path"
        break
    done
}

# ディレクトリ内の一括変換
handle_directory_conversion() {
    while true; do
        read -p "変換対象のディレクトリパスを入力してください (終了する場合は 'q' を入力): " dir_path
        if [[ "$dir_path" == "q" ]]; then
            break
        fi

        if [ ! -d "$dir_path" ]; then
            echo "指定されたディレクトリが見つかりません。再入力してください。"
            continue
        fi

        # findコマンドで対象ファイルを検索
        # -maxdepth 1 でサブディレクトリは検索しない
        local target_files=()
        while IFS= read -r file; do
            target_files+=("$file")
        done < <(find "$dir_path" -maxdepth 1 -type f \( -iname "*.wav" -o -iname "*.mp3" -o -iname "*.m4a" \))

        local total_files=${#target_files[@]}
        if [ $total_files -eq 0 ]; then
            echo "ディレクトリ内に変換対象のファイルが見つかりませんでした。"
            break
        fi

        echo "対象ファイル数: $total_files 件"
        local success_count=0
        local failure_count=0
        local current_file_index=0

        for file_path in "${target_files[@]}"; do
            current_file_index=$((current_file_index + 1))
            echo "($current_file_index/$total_files) ファイルを変換中: $(basename "$file_path")..."
            
            run_ffmpeg_command "$file_path"
            local exit_code=$?

            if [ $exit_code -eq 0 ]; then
                success_count=$((success_count + 1))
            else
                failure_count=$((failure_count + 1))
            fi
        done

        echo "変換が完了しました。成功: $success_count 件, 失敗: $failure_count 件"
        break
    done
}

# メイン処理
main() {
    display_splash
    while true; do
        display_menu
        case $? in
            1)
                handle_brew_update
                ;;
            2)
                handle_single_file_conversion
                ;;
            3)
                handle_directory_conversion
                ;;
            4)
                echo "プログラムを終了します。"
                exit 0
                ;;
            *)
                echo "無効な選択です。1から4の数字を入力してください。"
                ;;
        esac
        echo ""
    done
}

# スクリプト開始
main