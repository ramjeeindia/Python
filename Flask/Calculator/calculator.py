from flask import Flask,render_template , request
app = Flask(__name__)

# http://192.168.1.4:5002/ramjee
@app.route('/ramjee')
def cal_page():
    return render_template('cal.html')


@app.route("/math", methods = ['POST'])
def calculator_test():
    ops = request.form['operation']
    first_num = int(request.form['num1'])
    second_num = int(request.form['num2'])

    if(ops =='add'):
        r = first_num + second_num
        return f"addition of {first_num} and {second_num} is {r}"
    if(ops == 'subtract'):
        r = first_num - second_num
        return f"subtraction  of {first_num} and {second_num} is {r}"
    if(ops == 'multiply'):
        r = first_num * second_num
        return f"multiply  of {first_num} and {second_num} is {r}"
    if(ops == 'divide'):
        r = first_num / second_num
        return f"divide  of {first_num} and {second_num} is {r}"

if __name__ == '__main__':
    app.run(host='0.0.0.0' , port=5002)