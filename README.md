# Ubuntu VNC-noVNC Container 🐧✨

![Version](https://img.shields.io/badge/version-v1.2.6-blue.svg)

## Overview 🚀

Welcome to the **Ubuntu VNC Container** project! This Docker container is meticulously crafted to deliver a **lightweight** and **user-friendly** environment for running the **XFCE desktop environment** on a robust Ubuntu base. With seamless integration of a **VNC server**, this container enables you to connect remotely, facilitating **development**, **testing**, or simply accessing a **graphical interface** from virtually anywhere. 
In addition to traditional VNC access, this project incorporates **noVNC**, allowing you to connect to your desktop environment through a **web browser** without the need for a VNC client. This added flexibility ensures that you can easily manage your applications and resources on the go, making it an ideal solution for **developers**, **remote teams**, and anyone looking to utilize a graphical interface in a **cloud environment**. 
Whether you are looking to run applications, perform system administration tasks, or simply enjoy a graphical user experience, the **Ubuntu VNC-noVNC Container** provides a **versatile platform** to meet your needs. Join us in exploring the capabilities of this powerful containerized solution! 🌐✨

## Features 🌟

- **Ubuntu Base**: Built on the latest Ubuntu image, ensuring compatibility and security.
- **XFCE Desktop**: A lightweight desktop environment that is easy on resources.
- **VNC Access**: Connect remotely using VNC clients (like UltraVNC) to manage your desktop.
- **Wine Support**: Install and run Windows applications seamlessly with Wine.
- **Custom User**: A dedicated user, **Mahdi**, is created for a better and safer experience.
- **noVNC Support**: Access your desktop environment through a web browser using noVNC, which provides a more versatile and platform-independent solution.

## Getting Started 💻

To get started with this container, follow these steps:

### Clone the Repository:

```bash
git clone https://github.com/Mahdi80s/Ubuntu-VNC-noVNC-Container.git
```

### Build the Docker Image:

```bash
docker build -f Dockerfile -t ubuntu-vnc .
```

### Run the Container:

```bash
docker run -dit -p 5901:5901 -p 6080:6080 -p 5902:5902 -p 5903:5903 -p 5904:5904 ubuntu-vnc or
docker run -dit --network host ubuntu-vnc
```

### Connect via VNC:

Use your favorite VNC client (like UltraVNC) to connect to the following address:

```
localhost:5901 #localhost=IP-host
```

You can download UltraVNC from [here](https://www.uvnc.com/).

### Setting Up VNC Server:

To set up the VNC server with TigerVNC, you can use the following command inside the running container:

```bash
tigervncserver -xstartup /usr/bin/startxfce4 -SecurityTypes VncAuth,TLSVnc -geometry 1024x768 -localhost no :1 #5901
tigervncserver -xstartup /usr/bin/startxfce4 -SecurityTypes VncAuth,TLSVnc -geometry 1024x768 -localhost no :2 #5902

```

### Setting Up noVNC:

To enable access via noVNC, follow these steps:

1. **Generate SSL Certificate**:

   Inside your Docker container, run:

   ```bash
   openssl req -x509 -nodes -newkey rsa:3072 -keyout novnc.pem -out novnc.pem -days 3650
   ```

   You will be prompted to enter information for your certificate request, such as:

   - **Country Name (2 letter code)**: `IR`
   - **State or Province Name**: `Tehran`
   - **Locality Name**: `Tehran`
   - **Organization Name**: `Mahdi`
   - **Organizational Unit Name**: `Mahdi-Sardari`
   - **Common Name**: `Mahdi.Sardari.com`
   - **Email Address**: `Mahdisardari80@outlook.com`

2. **Start WebSocket Proxy**:

   Next, start the websockify server to enable noVNC:

   ```bash
   websockify -D --web=/usr/share/novnc/ --cert=/home/Mahdi/novnc.pem 6080 localhost:5902
   ```

   This command sets up the following configurations:
   - **Listen on port**: `6080`
   - **Web server**: The web root is set to `/usr/share/novnc/`
   - **SSL/TLS support**: Enabled for secure connections
   - **Backgrounding**: Runs as a daemon

3. **Access via Web Browser**:

   You can now access your XFCE desktop environment via a web browser at:

   ```
   http://Mahdi.Sardari.com:6080/vnc.html #Mahdi.Sardari.com=IP-host
   ```

## How It Works 🔧

- **VNC Setup**: The container uses **TigerVNC** for remote desktop access. During startup, a password is set for VNC access using an Expect script (entrypoint.exp). This ensures that you can securely connect to the desktop session.
  
- **noVNC**: The noVNC server provides a web-based VNC client that allows you to connect to your XFCE desktop from any modern web browser, offering flexibility and ease of access.

- **Entry Point**: The container runs a bash script (up-container.sh) that calls the Expect script to set up the VNC server and keeps the container alive.

## Requirements 📦

- Docker installed on your machine.
- A VNC client (e.g., UltraVNC) for connecting to the container.
- A modern web browser to access the noVNC interface.

## Contribution 🤝

Feel free to fork the repository and submit pull requests for any enhancements or fixes. Contributions are always welcome!

Thank you for checking out the **Ubuntu VNC Container**! If you have any questions or feedback, please reach out via issues or contact me directly at mahdisardari80@outlook.com. Happy coding! 🎉

---
