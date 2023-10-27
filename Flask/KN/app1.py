from flask import Flask
### WSGI Application
app1=Flask(__name__)

# decorator '/' to define url
@app1.route('/')
def welcome():
    return'Welcome to Flask world'

if __name__=='__main__':
    app1.run()
    # app.run(debug=True) This wiil up always
   
   
    
''' we can execute cmd 
 cd Flask
 cd KN
 
 pip install -r requirements.txt
 
'''