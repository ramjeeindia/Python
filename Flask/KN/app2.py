# Building URL Dynamically
# variable Rules and URL building

from flask import Flask

app2 = Flask(__name__)

@app2.route('/')
def welcome():
    return("hello")


#sucess/<int:score> this will dynamically give result
@app2.route('/sucess/<int:score>')
def sucess(score):
    # typecast int to str +str(score)
    return"The Person has passed and marks is "+str(score)
# for check http://127.0.0.1:5000/sucess/80


@app2.route('/fail/<int:score>')
def fail(score):
    return"The Person has failed and marks is "+str(score)
# for fail http://127.0.0.1:5000/fail/80

# result checker
@app2.route('/results/<int:score>')
def result(score):
    if score<50:
        result="fail"
    else:
        result="sucess"
    return result
        
    return"The Person has failed and marks is "+str(score)
# for result http://127.0.0.1:5000/results/80


if __name__=='__main__':
    app2.run(debug=True)