#!/usr/bin/expect

# ホスト名、ユーザー名、パスワード、転送先ディレクトリの設定
set HOST 192.168.0.18 #ip
set USER testuser #ID
set PASS passws #PASS
set TARGET_DIR test #PATH

# ファイルを格納しているディレクトリのパス
set SOURCE_DIR /Users/seikinaoya/Documents/shell/test

# ディレクトリ内のファイル一覧を取得
set files [glob -directory $SOURCE_DIR *]

# ファイルをループで転送
foreach file $files {
    spawn scp $file ${USER}@${HOST}:${TARGET_DIR}
    expect {
        "Are you sure you want to continue connecting (yes/no)?" {
            send "yes\r"
            expect "password:"
            send "$PASS\r"
        }
        "password:" {
            send "$PASS\r"
        }
        "100%" {
            # ファイルの転送完了を待つ
        }
    }
    expect {
        "Are you sure you want to continue connecting (yes/no)?" {
            send "yes\r"
        }
        eof
    }
}

# Expectの対話モードを終了
interact
