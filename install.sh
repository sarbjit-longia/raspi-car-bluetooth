echo "[+] Starting the installation of scripts..."
sudo cp ./files/10-local.rules /etc/udev/rules.d/
sudo cp ./files/bluepower.target  /lib/systemd/system/bluepower.target
sudo systemctl enable bluepower.target

sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo cp ./files/autologin.conf /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo cp ./files/cron_script.sh ~/
sudo cp ./files/connect_device.sh ~/

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

echo $1 > ~/.mac_address

echo "[+] Installing crontab entries.."

crontab -l > mycron
echo "* * * * * /home/dragon/cron_script.sh" >> mycron
crontab mycron
rm mycron
