# Building URL Dynamically
# variable Rules and URL building

from flask import Flask, redirect, url_for # redirect is for url and url_for is for dynamically call another url

app3 = Flask(__name__)

@app3.route('/')
def welcome():
    return("hello")


#sucess/<int:score> this will dynamically give result
@app3.route('/sucess/<int:score>')
def sucess(score):
    # typecast int to str +str(score)
    # return"The Person has passed and marks is "+str(score)

# we can also return message in html format
    return "<html><body><h1>The result is passed</h1></body></html>"
# for check http://127.0.0.1:5000/sucess/80


@app3.route('/fail/<int:score>')
def fail(score):
    return"The Person has failed and marks is "+str(score)
# for fail http://127.0.0.1:5000/fail/80

# result checker
@app3.route('/results/<int:marks>')
def result(marks):
    result=""
    
    if marks<50:
        result="fail" # THIS IS REDIRECT TO FAIL PAGE
    else:
        result="sucess" # THIS IS REDIRECT TO SUCESS PAGE
    return redirect(url_for(result,score=marks))
        
    
# for result http://127.0.0.1:5000/results/80


if __name__=='__main__':
    app3.run(debug=True)