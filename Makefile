# Makefile
# Збірка коду для Linux
linux:
	make linux

# Збірка коду для arm
arm:
	make arm

# Збірка коду для macOS
macos:
	make macos

# Збірка коду для Windows
windows:
	make windows

# Видалення новоствореного образу
clean:
	 rm main main-linux main-windows main-macos main-linux-arm 
        docker rmi jira:latest    
