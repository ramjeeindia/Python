from flask import Flask , request, jsonify, render_template
app = Flask(__name__)

# create a folder name temlated then pass data in form using html file

@app.route("/")
def show_form():
    return render_template('form.html')

def check_password():
    name = request.form.get('username')
    password = request.form.get('password')

    return "username and password received"

if __name__ == "__main__":
    app.run(host="0.0.0.0" ,port=5006)

# https://orange-judge-muatb.pwskills.app:5000/



