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
    # this result will put in result.html file as  <h2>{{result}}</h2>

# for check http://127.0.0.1:5000/sucess/80


@app.route('/fail/<int:score>')
def fail(score):
    return"The Person has failed and marks is "+str(score)
# for fail http://127.0.0.1:5000/fail/80

# USE METHOD GET AND POST RESULT CHECKER AFTER SUBMIT BUTTON 
@app.route('/submit',methods=['POST','GET'])
def submit():
    total_score=0
    if request.method=='POST':
        science=float(request.form['science'])
        Maths=float(request.form['Maths'])
        Data_Science=float(request.form['Data Science'])
        total_score=science+Maths+Data_Science
        res=""
        if total_score>=50:
            res="sucess" # THIS IS REDIRECT TO sucess PAGE
        else:
            res="fail" # THIS IS REDIRECT TO FAIL PAGE
        return redirect(url_for(res,score=total_score))    
   
        
    
# for result http://127.0.0.1:5000/results/80


if __name__=='__main__':
    app.run(debug=True)