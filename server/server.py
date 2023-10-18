import socket
import time
import requests
import random
import json
import threading

def get_public_ipv4_address():
    try:
        # Use a reliable service like 'httpbin.org' to get your public IP address
        response = requests.get('https://httpbin.org/ip')
        if response.status_code == 200:
            data = response.json()
            public_ip = data.get('origin', 'Unable to retrieve public IP')
            return public_ip
        else:
            return 'Unable to retrieve public IP'
    except Exception as e:
        return str(e)

def get_local_ip_address():
    try:
        # Create a socket object
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.settimeout(0.1)

        # Connect to a remote server, doesn't matter which one
        s.connect(("8.8.8.8", 80))

        # Get the local IP address
        local_ip = s.getsockname()[0]

        return local_ip
    except Exception as e:
        return str(e)

def printStockTable(stocks):
    print("\nStock Name\tStock Price")
    print("-" * 30)
    for stock_name, stock_price in stocks.items():
        print(f"{stock_name}\t\t{stock_price}")

def getStocks():
    _stocks = {}
    _j = int(input("Enter how many stocks you want: "))
    for i in range(_j):
        _stocks[input(f"Enter Name of {i+1} stock: ")] = random.choice([i for i in range(500, 2500)])
    return _stocks

import time

stocks_lock = threading.Lock()

def updateStockPrices(stocks, operation, stock_name, duration):
    start_time = time.time()

    while time.time() - start_time < duration:
        with stocks_lock:
            if operation == "+":
                stocks[stock_name] += random.randint(1, 10)
            elif operation == "-":
                stocks[stock_name] -= random.randint(1, 10)
        time.sleep(1)  # Sleep for 1 second between updates

    print(f"Stock price update for {stock_name} complete, {stocks[stock_name]}")


def sendStockData(client_socket, stocks):
    try:
        while True:
            # Send data to the client
            json_stocks = json.dumps(stocks)
            data = json_stocks
            client_socket.send(data.encode())
            time.sleep(2)
    except (BrokenPipeError, ConnectionResetError, OSError):
        print("Client disconnected")
    finally:
        client_socket.close()

    

def user_input_thread(stocks):
    while True:
        print("Enter '+' to increase stock price, '-' to decrease stock price, or 'exit' to stop:")
        user_input = input()

        if user_input == "exit":
            break

        if user_input in ("+", "-"):
            printStockTable(stocks)
            stock_name = input("Enter the stock name to modify: ")

            if stock_name in stocks:
                try:
                    duration = int(input("Enter the duration (in seconds): "))
                    if duration > 0:
                        # Start a new thread to update stock prices in the background
                        stock_update_thread = threading.Thread(target=updateStockPrices, args=(stocks, user_input, stock_name, duration))
                        stock_update_thread.start()
                    else:
                        print("Duration must be a positive integer.")
                except ValueError:
                    print("Invalid duration. Please enter a positive integer.")
            else:
                print("Invalid stock name. Please enter a valid stock name.")
        else:
            print("Invalid input. Please enter '+' or '-' for operation or 'exit' to stop.")


stocks = getStocks()

myIP = get_local_ip_address()
print(f"The Server's IP: {myIP}")

# Create a socket
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to a specific address and port
server_socket.bind(('0.0.0.0', 12345))

# Listen for incoming connections
server_socket.listen(5)

print("Server is listening for clients...")

# Create a thread for user input
user_input_thread = threading.Thread(target=user_input_thread, args=(stocks,))
user_input_thread.start()

# ... (Previous code)

try:
    while True:
        # Accept a new client connection
        client_socket, client_address = server_socket.accept()
        print(f"Connected to {client_address}")

        # Create a thread for sending stock data to the client
        send_data_thread = threading.Thread(target=sendStockData, args=(client_socket, stocks))
        send_data_thread.start()

        # It's a good practice to close the client socket in the send_data_thread when the client disconnects,
        # so there's no need to do it here in the try block.

except KeyboardInterrupt:
    print("Server terminated by user.")

finally:
    server_socket.close()  # Close the server socket when the server is terminated
