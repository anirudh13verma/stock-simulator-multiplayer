import socket

# Create a socket
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect to the server
serverID = input("Enter Server IP: ")
server_address = (serverID, 12345)
client_socket.connect(server_address)

while True:
    # Receive data from the server
    data = client_socket.recv(1024).decode()
    print(f"Received: {data}")
