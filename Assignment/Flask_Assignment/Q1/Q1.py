# 1. Create a Flask app that displays "Hello, World!" on the homepage.

from flask import Flask

Q1 = Flask(__name__)


# DEFINE ROUTE

@Q1.route('/')

def display():
    return 'Hello World !'

if __name__ == '__main__':
    Q1.run(host='0.0.0.0', port=5001)


