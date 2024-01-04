# python -m pip install flask 

from flask import Flask ,request
app = Flask(__name__)


# if we assign '/add' then url will be http://192.168.1.4:5000/add other http://192.168.1.4:5000
# @app.route('/add')
@app.route('/')
def addition():
   return f"This is add mode Call"



if __name__ =='__main__':
    app.run(host="0.0.0.0", port=5000)