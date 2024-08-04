#!/bin/bash

# 设置 ASAN 选项
export ASAN_OPTIONS="poison_heap=false:poison_partial=false:poison_array_cookie=false:allow_user_poisoning=false:alloc_dealloc_mismatch=false:new_delete_type_mismatch=false:detect_leaks=false:check_printf=false:detect_container_overflow=false:detect_deadlocks=false:detect_write_exec=false:detect_odr_violation=0:strict_string_checks=false:strict_memcmp=false:intercept_strstr=false:intercept_strspn=false:intercept_strtok=false:intercept_strpbrk=false:intercept_strlen=false:intercept_strndup=false:intercept_strchr=false:intercept_memcmp=false:intercept_memmem=false:intercept_intrin=false:intercept_stat=false:intercept_send=false:replace_intrin=false:replace_str=false:report_globals=0:malloc_context_size=0:allocator_release_to_os_interval_ms=5000:quarantine_size_mb=16:max_malloc_fill_size=512:max_redzone=64"

# 清屏
clear

# 定义全局变量
SERVER_DIR="/genshin"
VIAGENSHIN_GAMEPORT=1234
ORIGIN_GAMEPORT=20041

# 获取系统的首个 IP 地址
SYSTEM_IP=$(hostname -I | cut -d' ' -f1)

# 获取服务端 IP 地址
SERVER_IP=$(grep -oP '<Server .* inner_ip="\K[^"]+' $SERVER_DIR/gameserver/conf/gameserver.xml)

# 检查 Gateserver 状态
check_gateserver_status() {
    local pid=$(ps aux | grep "./gateserver -i 9001.1.1.1" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "Gateserver 正在运行（PID：$pid），输入 A 以关闭"
    else
        echo "Gateserver 未运行，输入 A 以启动"
    fi
}

# 检查 Gameserver 状态
check_gameserver_status() {
    local pid=$(ps aux | grep "./gameserver -i 9001.2.1.1" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "Gameserver 正在运行（PID：$pid），输入 B 以关闭"
    else
        echo "Gameserver 未运行，输入 B 以启动"
    fi
}

# 检查 Nodeserver 状态
check_nodeserver_status() {
    local pid=$(ps aux | grep "./nodeserver -i 9001.3.1.1" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "Nodeserver 正在运行（PID：$pid），输入 C 以关闭"
    else
        echo "Nodeserver 未运行，输入 C 以启动"
    fi
}

# 检查 DBgate 状态
check_dbgate_status() {
    local pid=$(ps aux | grep "./dbgate -i 9001.4.1.1" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "DBgate 正在运行（PID：$pid），输入 D 以关闭"
    else
        echo "DBgate 未运行，输入 D 以启动"
    fi
}

# 检查 Dispatch 状态
check_dispatch_status() {
    local pid=$(ps aux | grep "./dispatch -i 9001.5.1.1" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "Dispatch 正在运行（PID：$pid），输入 E 以关闭"
    else
        echo "Dispatch 未运行，输入 E 以启动"
    fi
}

# 检查 NewDispatch 状态
check_newdispatch_status() {
    local pid=$(ps aux | grep "./newdispatch" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "NewDispatch 正在运行（PID：$pid），输入 F 以关闭"
    else
        echo "NewDispatch 未运行，输入 F 以启动"
    fi
}

# 检查 MUIPserver 状态
check_muipserver_status() {
    local pid=$(ps aux | grep "./muipserver -i 9001.6.1.1" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "MUIPserver 正在运行（PID：$pid），输入 G 以关闭"
    else
        echo "MUIPserver 未运行，输入 G 以启动"
    fi
}

# 检查 Multiserver 状态
check_multiserver_status() {
    local pid=$(ps aux | grep "./multiserver -i 9001.7.1.1" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "Multiserver 正在运行（PID：$pid），输入 H 以关闭"
    else
        echo "Multiserver 未运行，输入 H 以启动"
    fi
}

# 检查 ViaGenshin 状态
check_viagenshin_status() {
    local pid=$(ps aux | grep "./ViaGenshin" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "ViaGenshin 正在运行（PID：$pid），输入 I 以关闭"
    else
        echo "ViaGenshin 未运行，输入 I 以启动"
    fi
}

# 检查 CokeSDK 状态
check_cokesdk_status() {
    local pid=$(ps aux | grep "cokesdk/main.py serve" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "CokeSDK 正在运行（PID：$pid），输入 J 以关闭"
    else
        echo "CokeSDK 未运行，输入 J 以启动"
    fi
}

# 检查 GCSDK 状态
check_gcsdk_status() {
    local pid=$(ps aux | grep "java -jar ./sdkserver.jar" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ];then
        echo "GCSDK 正在运行（PID：$pid），输入 K 以关闭"
    else
        echo "GCSDK 未运行，输入 K 以启动"
    fi
}

# 检查 hk4e-emu 状态
check_hk4eemu_status() {
    local pid=$(ps aux | grep "./hk4e-emu" | grep -v "bash" | grep -v "grep" | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "hk4e-emu 正在运行（PID：$pid），输入 L 以关闭"
    else
        echo "hk4e-emu 未运行，输入 L 以启动"
    fi
}

# 检查所有服务状态
check_service_status() {
    check_gateserver_status
    check_gameserver_status
    check_nodeserver_status
    check_dbgate_status
    check_dispatch_status
    check_newdispatch_status
    check_muipserver_status
    check_multiserver_status
    check_viagenshin_status
    check_cokesdk_status
    check_gcsdk_status
    check_hk4eemu_status
}

# 更新服务端 IP 地址
update_server_ip() {
    if [ -z "$SYSTEM_IP" ] || [ -z "$SERVER_IP" ]; then
        echo "错误：请检查网络状态和服务端配置。无法获取 SYSTEM_IP 或 SERVER_IP。"
        return 1
    fi
    cd "$SERVER_DIR"
    find . -name "*.xml" -exec sed -i "s/$SERVER_IP/$SYSTEM_IP/g" {} +
    find . -name "config.json" -exec sed -i "s/$SERVER_IP/$SYSTEM_IP/g" {} +
    echo 服务端 IP 地址更新完成。
}

# 赋予所有服务端执行权限
chmod_server_bin() {
    chmod +x "$SERVER_DIR/nodeserver/nodeserver"
    chmod +x "$SERVER_DIR/gateserver/gateserver"
    chmod +x "$SERVER_DIR/dbgate/dbgate"
    chmod +x "$SERVER_DIR/dispatch/dispatch"
    chmod +x "$SERVER_DIR/newdispatch/dispatch"
    chmod +x "$SERVER_DIR/gameserver/gameserver"
    chmod +x "$SERVER_DIR/muipserver/muipserver"
    chmod +x "$SERVER_DIR/multiserver/multiserver"
    chmod +x "$SERVER_DIR/viagenshin/ViaGenshin"
    chmod +x "$SERVER_DIR/hk4e-emu/hk4e-emu"
    echo "已赋予服务端文件执行权限。"
}

# 启动 Nodeserver
start_nodeserver() {
    echo "启动 Nodeserver……"
    nohup bash -c "cd $SERVER_DIR/nodeserver && ./nodeserver -i 9001.3.1.1 >/dev/null 2>&1 &"
}

# 启动 Gateserver
start_gateserver() {
    echo "启动 Gateserver……"
    nohup bash -c "cd $SERVER_DIR/gateserver && ./gateserver -i 9001.1.1.1 >/dev/null 2>&1 &"
}

# 启动 DBgate
start_dbgate() {
    echo "启动 DBgate……"
    nohup bash -c "cd $SERVER_DIR/dbgate && ./dbgate -i 9001.4.1.1 >/dev/null 2>&1 &"
}

# 启动 Dispatch
start_dispatch() {
    echo "启动 Dispatch……"
    nohup bash -c "cd $SERVER_DIR/dispatch && ./newdispatch -i 9001.5.1.1 >/dev/null 2>&1 &"
}

# 启动 NewDispatch
start_newdispatch() {
    echo "启动 NewDispatch……"
    nohup bash -c "cd $SERVER_DIR/newdispatch && ./newdispatch >/dev/null 2>&1 &"
}

# 启动 Gameserver
start_gameserver() {
    echo "启动 Gameserver……"
    nohup bash -c "cd $SERVER_DIR/gameserver && ./gameserver -i 9001.2.1.1 >/dev/null 2>&1 &"
}

# 启动 MUIPserver
start_muipserver() {
    echo "启动 MUIPserver……"
    nohup bash -c "cd $SERVER_DIR/muipserver && ./muipserver -i 9001.6.1.1 >/dev/null 2>&1 &"
}

# 启动 Multiserver
start_multiserver() {
    echo "启动 Multiserver……"
    nohup bash -c "cd $SERVER_DIR/multiserver && ./multiserver -i 9001.7.1.1 >/dev/null 2>&1 &"
}

# 启动 ViaGenshin
start_viagenshin() {
    echo "启动 ViaGenshin……"
    nohup bash -c "cd $SERVER_DIR/viagenshin && ./ViaGenshin >/dev/null 2>&1 &"
}

# 启动 CokeSDK
start_cokesdk() {
    echo "启动 CokeSDK……"
    nohup bash -c "cd $SERVER_DIR/cokesdk && ../python3.9.13/bin/python3 main.py serve >/dev/null 2>&1 &"
}

# 启动 GCSDK
start_gcsdk() {
    echo "启动 GCSDK……"
    nohup bash -c "cd $SERVER_DIR/gcsdk && ../jdk-17.0.12/bin/java -jar ./sdkserver.jar >/dev/null 2>&1 &"
}

# 启动 hk4e-emu
start_hk4eemu() {
    echo "启动 hk4e-emu……"
    nohup bash -c "cd $SERVER_DIR/hk4e-emu && ./hk4e-emu >/dev/null 2>&1 &"
}


# 启动仅单人服务端
start_singleserver() {
    echo "开始启动仅单人服务端……"
    start_nodeserver
    start_gateserver
    start_dbgate
    start_gameserver
    start_muipserver
    start_viagenshin
    start_hk4eemu
}

# 启动完整服务端
start_fullserver() {
    echo "开始启动完整服务端……"
    start_nodeserver
    start_gateserver
    start_dbgate
    start_gameserver
    start_muipserver
    start_multiserver
    start_viagenshin
    start_hk4eemu
}

# 清除服务端日志
clear_server_logs() {
    echo "开始清理所有服务端日志……"
    directories=(
        "$SERVER_DIR/hk4e-emu/log"
        "$SERVER_DIR/cokesdk/logs"
        "$SERVER_DIR/gcsdk/logs"
        "$SERVER_DIR/dispatch/log"
        "$SERVER_DIR/dispatch/mem_perf"
        "$SERVER_DIR/muipserver/log"
        "$SERVER_DIR/muipserver/mem_perf"
        "$SERVER_DIR/multiserver/log"
        "$SERVER_DIR/multiserver/mem_perf"   
        "$SERVER_DIR/gameserver/log"
        "$SERVER_DIR/gameserver/mem_perf"
        "$SERVER_DIR/gateserver/log"
        "$SERVER_DIR/gateserver/mem_perf"
        "$SERVER_DIR/nodeserver/log"
        "$SERVER_DIR/nodeserver/mem_perf"
        "$SERVER_DIR/dbgate/log"
        "$SERVER_DIR/dbgate/mem_perf"
    )
    for dir in "${directories[@]}"; do
        if [ -d "$dir" ]; then
            rm -rf "$dir"/*
        fi
    done
    rm -rf "$SERVER_DIR/viagenshin/ViaGenshin.log"
    rm -rf "$SERVER_DIR/newdispatch/dispatch.log"
    rm -rf "$SERVER_DIR/viagenshin/pid" 
    rm -rf "$SERVER_DIR/nohup.out"
    echo 完成清理所有服务端日志。
}

# 重启服务端
restart_server() {
    if [ "$last_mode" == "" ]; then
        echo "服务端未启动。启动服务端后可以使用重启功能。"
    elif [ "$last_mode" == "singleserver" ]; then
        stop_server
        start_singleserver
        echo "完成仅单人服务端重启。"
    elif [ "$last_mode" == "fullserver" ]; then
        stop_server
        start_fullserver
        echo "完成完整服务端重启。"
    fi
}

# 关闭 Nodeserver
stop_nodeserver() {
    echo "停止 Nodeserver……"
    pkill -f -9 "nodeserver -i 9001.3.1.1"
}

# 关闭 Gateserver
stop_gateserver() {
    echo "停止 Gateserver……"
    pkill -f -9 "gateserver -i 9001.1.1.1"
}

# 关闭 DBgate
stop_dbgate() {
    echo "停止 DBgate……"
    pkill -f -9 "dbgate -i 9001.4.1.1"
}

# 关闭 Dispatch
stop_dispatch() {
    echo "停止 Dispatch……"
    pkill -f -9 "dispatch -i 9001.5.1.1"
}

# 关闭 NewDispatch
stop_newdispatch() {
    echo "停止 NewDispatch……"
    pkill -f -9 "newdispatch"
}

# 关闭 Gameserver
stop_gameserver() {
    echo "停止 Gameserver……"
    pkill -f -9 "gameserver -i 9001.2.1.1"
}

# 关闭 MUIPserver
stop_muipserver() {
    echo "停止 MUIPserver……"
    pkill -f -9 "muipserver -i 9001.6.1.1"
}

# 关闭 Multiserver
stop_multiserver() {
    echo "停止 Multiserver……"
    pkill -f -9 "multiserver -i 9001.7.1.1"
}

# 关闭 ViaGenshin
stop_viagenshin() {
    echo "停止 ViaGenshin……"
    pkill -f -9 "ViaGenshin"
}

# 关闭 CokeSDK
stop_cokesdk() {
    echo "停止 CokeSDK……"
    pkill -f -9 "cokesdk/main.py serve"
}

# 关闭 GCSDK
stop_gcsdk() {
    echo "停止 GCSDK……"
    pkill -f -9 "sdkserver.jar"
}

# 关闭 hk4e-emu
stop_hk4eemu() {
    echo "停止 hk4e-emu……"
    pkill -f -9 "hk4e-emu"
}

# 修改 Nodeserver
modify_nodeserver() {
    if pgrep -f "nodeserver -i 9001.3.1.1" > /dev/null; then
        stop_nodeserver
    else
        start_nodeserver
    fi
}

# 修改 Gateserver
modify_gateserver() {
    if pgrep -f "gateserver -i 9001.1.1.1" > /dev/null; then
        stop_gateserver
    else
        start_gateserver
    fi
}

# 修改 DBgate
modify_dbgate() {
    if pgrep -f "dbgate -i 9001.4.1.1" > /dev/null; then
        stop_dbgate
    else
        start_dbgate
    fi
}

# 修改 Dispatch
modify_dispatch() {
    if pgrep -f "dispatch -i 9001.5.1.1" > /dev/null; then
        stop_dispatch
    else
        start_dispatch
    fi
}

# 修改 NewDispatch
modify_newdispatch() {
    if pgrep -f "newdispatch" > /dev/null; then
        stop_newdispatch
    else
        start_newdispatch
    fi
}

# 修改 Gameserver
modify_gameserver() {
    if pgrep -f "gameserver -i 9001.2.1.1" > /dev/null; then
        stop_gameserver
    else
        start_gameserver
    fi
}

# 修改 MUIPserver
modify_muipserver() {
    if pgrep -f "muipserver -i 9001.6.1.1" > /dev/null; then
        stop_muipserver
    else
        start_muipserver
    fi
}

# 修改 Multiserver
modify_multiserver() {
    if pgrep -f "multiserver -i 9001.7.1.1" > /dev/null; then
        stop_multiserver
    else
        start_multiserver
    fi
}

# 修改 ViaGenshin
modify_viagenshin() {
    if pgrep -f "ViaGenshin" > /dev/null; then
        stop_viagenshin
    else
        start_viagenshin
    fi
}

# 修改 CokeSDK
modify_cokesdk() {
    if pgrep -f "cokesdk/main.py serve" > /dev/null; then
        stop_cokesdk
    else
        start_cokesdk
    fi
}

# 修改 GCSDK
modify_gcsdk() {
    if pgrep -f "sdkserver.jar" > /dev/null; then
        stop_gcsdk
    else
        start_gcsdk
    fi
}

# 修改 hk4e-emu
modify_hk4eemu() {
    if pgrep -f "hk4e-emu" > /dev/null; then
        stop_hk4eemu
    else
        start_hk4eemu
    fi
}

# 关闭服务端
stop_server() {
    echo "开始关闭服务端……"
    stop_nodeserver
    stop_gateserver
    stop_dbgate
    stop_newdispatch
    stop_gameserver
    stop_muipserver
    stop_multiserver
    stop_viagenshin
    stop_gcsdk
    stop_hk4eemu
}

# 检查系统是否安装了 iptables
if ! command -v iptables &>/dev/null; then
    iptables_installed=false
else
    iptables_installed=true
fi

# 检查 iptables 规则是否存在
check_iptables_rule() {
    if $iptables_installed && iptables -t nat -C PREROUTING -p udp --dport $ORIGIN_GAMEPORT -j REDIRECT --to-port $VIAGENSHIN_GAMEPORT 2>/dev/null; then
        iptables_rule_exists=true
    else
        iptables_rule_exists=false
    fi
}

# 添加 iptables 规则
update_iptables() {
    iptables -A PREROUTING -t nat -p udp --dport $ORIGIN_GAMEPORT -j REDIRECT --to-port $VIAGENSHIN_GAMEPORT
    echo "已添加游戏服务器端口 $ORIGIN_GAMEPORT 到 ViaGenshin 端口 $VIAGENSHIN_GAMEPORT 的 iptables 转发规则。"
}

# 删除 iptables 规则
delete_iptables() {
    iptables -D PREROUTING -t nat -p udp --dport $ORIGIN_GAMEPORT -j REDIRECT --to-port $VIAGENSHIN_GAMEPORT
    echo "游戏服务器端口 $ORIGIN_GAMEPORT 到 ViaGenshin 端口 $VIAGENSHIN_GAMEPORT 的 iptables 转发规则已被删除。"
}

# 在主循环之前检查 iptables 规则
check_iptables_rule

# 主循环
while true; do
    # 获取当前日期和时间
    CURRENT_DATE=$(date +"%Y 年 %m 月 %d 日 %H:%M")

    # 获取 CPU 使用率
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 + $6 + $10 + $12 + $14}')

    # 获取内存使用率
    MEMORY_INFO=$(free -m)
    TOTAL_MEM=$(echo "$MEMORY_INFO" | awk '/Mem:/ {print $2}')
    USED_MEM=$(echo "$MEMORY_INFO" | awk '/Mem:/ {print $3}')
    MEMORY_USAGE=$(awk "BEGIN {printf \"%.2f\", ($USED_MEM/$TOTAL_MEM)*100}")

    echo "======================================================================"
    echo "欢迎使用 GIO Control Panel！"
    echo "======================================================================"
    echo "系统 IP：$SYSTEM_IP"
    echo "服务端 IP：$SERVER_IP"
    echo "时间：$CURRENT_DATE"
    echo "CPU 使用率：$CPU_USAGE%"
    echo "内存使用率: 已用内存 $USED_MEM MB，总内存 $TOTAL_MEM MB，内存使用率 $MEMORY_USAGE%"
    echo "======================================================================"
    check_service_status
    echo "======================================================================"
    echo "1：更新服务端 IP"
    echo "2：启动仅单人服务端"
    echo "3：启动完整服务端"
    echo "4：清除服务端日志"
    echo "5：重启服务端"
    echo "6：关闭服务端"
    echo "7：修复服务端文件执行权限"   
    if [ "$iptables_installed" = true ]; then
        if [ "$iptables_rule_exists" = true ]; then
            echo "8：删除 iptables 游戏端口转发规则"
        else
            echo "8：添加 iptables 游戏端口转发规则"
        fi
    else
        echo "8：【iptables 未安装】添加或删除 iptables 游戏端口转发规则"
    fi
    echo "0：退出脚本（不会关闭服务端）"
    echo "======================================================================"
    read -t 5 -p "请输入选项数字：" choice
    if [[ -z "$choice" ]]; then
        clear
        continue
    fi
    case $choice in
        1)
            update_server_ip
            sleep 5
            clear
            ;;
        2)
            last_mode="singleserver"
            start_singleserver
            sleep 5
            clear
            ;;
        3)
            last_mode="fullserver"
            start_fullserver
            sleep 5
            clear
            ;;
        4)
            clear_server_logs
            sleep 5
            clear
            ;;
        5)
            restart_server
            sleep 5
            clear
            ;;
        6)
            stop_server
            sleep 5
            clear
            ;;
        7)
            chmod_server_bin
            sleep 5
            clear
            ;;
        8)
            if [ "$iptables_installed" = true ]; then
                if [ "$iptables_rule_exists" = true ]; then
                    delete_iptables
                else
                    update_iptables
                fi
            else
                echo "系统未安装 iptables。"
            fi
            sleep 5
            clear
            ;;
        A)
            modify_gateserver
            sleep 5
            clear
            ;;
        B)
            modify_gameserver
            sleep 5
            clear
            ;;
        C)
            modify_nodeserver
            sleep 5
            clear
            ;;
        D)
            modify_dbgate
            sleep 5
            clear
            ;;
        E)
            modify_dispatch
            sleep 5
            clear
            ;;
        F)
            modify_newdispatch
            sleep 5
            clear
            ;;
        G)
            modify_muipserver
            sleep 5
            clear
            ;;
        H)
            modify_multiserver
            sleep 5
            clear
            ;;
        I)
            modify_viagenshin
            sleep 5
            clear
            ;;
        J)
            modify_cokesdk
            sleep 5
            clear
            ;;
        K)
            modify_gcsdk
            sleep 5
            clear
            ;;
        L)
            modify_hk4eemu
            sleep 5
            clear
            ;;
        0)
            exit 0
            ;;
        *)
            echo "无效选项，请重新输入。"
            sleep 5
            clear
            ;;
    esac
done