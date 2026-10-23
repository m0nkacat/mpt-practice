import socket
import threading

clients = []
clients_lock = threading.Lock()


def broadcast(message, sender_socket):
    with clients_lock:
        for client in clients[:]:
            if client != sender_socket:
                try:
                    client.send(message.encode('utf-8'))
                except:
                    try:
                        client.close()
                    except:
                        pass
                    if client in clients:
                        clients.remove(client)


def handle_client(client_socket, client_address):
    print(f'Клиент {client_address} подключён')
    client_socket.send("Вы теперь в чате".encode('utf-8'))
    broadcast(f'Клиент {client_address} подключился', client_socket)
    while True:
        try:
            data = client_socket.recv(1024)
            if not data:
                break

            message = data.decode('utf-8')
            print(f'От {client_address}: {message}')

            broadcast(f'{client_address}: {message}', client_socket)

        except:
            break

    with clients_lock:
        if client_socket in clients:
            clients.remove(client_socket)

    client_socket.close()
    print(f'Клиент {client_address} отключился')

    broadcast(f'Клиент {client_address} отключился', client_socket)


server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind(('127.0.0.1', 5001))
server_socket.listen()

print('Сервер ждёт подключения клиентов')

while True:
    client_socket, client_address = server_socket.accept()

    with clients_lock:
        clients.append(client_socket)

    thread = threading.Thread(target=handle_client, args=(client_socket, client_address))
    thread.start()