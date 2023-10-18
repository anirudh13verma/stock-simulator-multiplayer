# Multiplayer Stock Simulator Game

> Warning: This game is Licensed under CC-BY-NC-SA. Use it appropriately

> Read Licensing Information [here]()

This is a Multiplayer Stock Simulator Game built using Flutter and Python. It aims to provide sole control to the host having following salient features:
* Add stocks as per your requirement with **user-feeded stock names**
* **Increase or decrease stock prices** at any instant of any stock of your choice
* Being a **multiplayer game**, it relies on the players to be on the same local network as the host/server


## Installation Guide

* First we need to ensure that the libraries required by the server are already installed. Run the following code to install the library **requests** which helps in data transfer between server and client
```bash
pip install requests  
```
* Now pick the appropriate release as per your operating system
    * **Windows** : [windows.zip]()
    * **Linux** : [linux.zip]()
    * **Android** (without server) : [android.apk]()


## Starting Server

To start the game, first you need to start the server. In order to do that, find the server.py in the extracted zip location and run following command:
```bash
python3 server.py
```
It will start the server and it ask you how many stocks do you want in the game
```
$ python3 server.py 
Enter how many stocks you want: 4
Enter Name of 1 stock: A
Enter Name of 2 stock: B
Enter Name of 3 stock: C
Enter Name of 4 stock: D
The Server's IP: 192.168.29.144
Server is listening for clients...
Enter '+' to increase stock price, '-' to decrease stock price, or 'exit' to stop:
```
For further guide on how to adjust stock prices, Read [Server Guide]()
