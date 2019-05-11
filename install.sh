echo "[+] Starting the installation of scripts..."
cp ./files/10-local.rules /etc/udev/rules.d/
cp ./files/bluepower.target  /lib/systemd/system/bluepower.target
sudo systemctl enable bluepower.target

mkdir -p /etc/systemd/system/getty@tty1.service.d
cp ./files/autologin.conf /etc/systemd/system/getty@tty1.service.d/autologin.conf

echo "pulseaudio -D" >> ~/.bashrc

echo "[+] Powering on bluetooth"
echo "power on" | bluetoothctl

echo "[+] Enabling agent"
echo "agent on" | bluetoothctl

echo "[+] Enabling scan"
echo "scan on" | bluetoothctl

echo "[+] Pairing bluetooth device"
echo "pair $1" | bluetoothctl
echo "trust $1" | bluetoothctl
echo "connect $1" | bluetoothctl

