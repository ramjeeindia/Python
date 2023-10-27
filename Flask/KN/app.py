# Integrate html file jinja2


from flask import Flask, redirect, url_for

app = Flask(__name__)

@app.route('/')
def welcome():
    return("hello")

        
    
# for result http://127.0.0.1:5000/results/80


if __name__=='__main__':
    app.run(debug=True)