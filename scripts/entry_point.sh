#!/usr/bin/env bash

# Create desktop entry for Chromium
mkdir -p /Desktop
cat << EOF > /Desktop/Chromium.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Google Chrome
Comment=Access the Internet
Exec=/usr/bin/google-chrome --no-sandbox --disable-dev-shm-usage
Icon=google-chrome
Path=
Terminal=false
StartupNotify=true
EOF
chmod +x /Desktop/Chromium.desktop

# Add user to /etc/passwd if needed
if ! whoami &> /dev/null; then
    if [ -w /etc/passwd ]; then
        echo "${USER_NAME:-ubuntu}:x:$(id -u):0:${USER_NAME:-ubuntu} user:/home/${USER_NAME:-ubuntu}:/sbin/nologin" >> /etc/passwd
    fi
fi

# Start Supervisor
/usr/bin/supervisord --configuration /etc/supervisor/supervisord.conf &

SUPERVISOR_PID=$!

# Function to handle shutdown
function shutdown {
    echo "Trapped SIGTERM/SIGINT so shutting down supervisord..."
    kill -s SIGTERM ${SUPERVISOR_PID}
    wait ${SUPERVISOR_PID}
    echo "Shutdown complete"
}

# Trap signals for shutdown
trap shutdown SIGTERM SIGINT

wait ${SUPERVISOR_PID}
