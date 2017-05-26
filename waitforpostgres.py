import socket
import time
import os

port = int(os.environ["POSTGRES_PORT"])

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
while True:
    try:
        s.connect(('postgres', port))
        s.close()
        print("Postgres is up")
        break
    except socket.error as ex:
        time.sleep(0.1)
        print("Postgres is unavailable - waiting")
