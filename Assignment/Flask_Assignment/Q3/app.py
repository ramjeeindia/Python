# 3. Develop a Flask app that uses URL parameters to display dynamic content.

from flask import Flask, render_template

app = Flask(__name__)

# Route the home page

@app.route('/<username>')

def welcome_page(username):
    return render_template('welcome.html', name='username')


 # Launch the webpage
 
if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5003)
    
    