# **Multiplayer Stock Simulator Game**

> Warning: This software is Licensed to [Anirudh Verma](https://github.com/anirudh13verma) under [CC-BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en). Use it appropriately

> Read Licensing Information [here](https://github.com/anirudh13verma/stock-simulator-multiplayer/blob/main/LICENSE)

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

To use the simulator, first you need to start the server. In order to do that, find the server.py in the extracted zip location and run following command or just double-click the file:
```bash
python3 server.py
```
It will start the server and it ask you how many stocks do you want in the game
```bash
$ python3 server.py 
```
```
Enter how many stocks you want: 4
Enter Name of 1 stock: A
Enter Name of 2 stock: B
Enter Name of 3 stock: C
Enter Name of 4 stock: D
The Server's IP: 192.168.29.144
Server is listening for clients...
Enter '+' to increase stock price, '-' to decrease stock price, or 'exit' to stop:
```
Here, you can see the Server's IP which will be used later to connect to the server

For further guide on how to adjust stock prices, Read [Server Guide]()

## Using the simulator
To use the simulator, run the appropriate app you downloaded/installed on your device. The app has cross-platform support

Enter the Server's IP in the Text Field and hit connect!

## **Licensing**

Multiplayer Stock Simulator Game © 2023 by [Anirudh Verma](https://github.com/anirudh13verma) is licensed under [Attribution-NonCommercial-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en)
Read License Information [here](https://github.com/anirudh13verma/stock-simulator-multiplayer/blob/main/LICENSE)

### Do's
User can:
* Use the software for **non-commercial** purposes only
* Showcase the software by respectfully **giving attributes** to the original creator (here [Anirudh Verma](https://github.com/anirudh13verma))
* Modify the code but must **fork it**, give **same licensing as original** and give **attributes** to the original creator

### Dont's
User can't:
* Use the software commercially
* Showcase without giving attributes to the original creator
* Modify the code without having the same licensing, attributes to original creator