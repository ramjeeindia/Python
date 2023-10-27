# Integrate html file jinja2
from flask import Flask, redirect, url_for, render_template,request # render template for integrate with html   
app = Flask(__name__)

@app.route('/')
def welcome():
   return render_template("index.html")

@app.route('/sucess/<int:score>')
def sucess(score):
    res=""  
    if score>=50:
        res="PASS"
    else:
        res="FAIL"
    return render_template('result.html',result=res)

@app.route('/fail/<int:score>')
def fail(score):
    return"The Person has failed and marks is "+str(score)

@app.route('/submit',methods=['POST','GET']) # USE METHOD GET AND POST RESULT CHECKER AFTER SUBMIT BUTTON 
def submit():
    total_score=0
    if request.method=='POST':
        science=float(request.form['science'])
        Maths=float(request.form['Maths'])
        Data_Science=float(request.form['Data Science'])
        total_score=science+Maths+Data_Science
        res=""
        return redirect(url_for('sucess',score=total_score))    # sucess variable handle the output

if __name__=='__main__':
    app.run(debug=True)