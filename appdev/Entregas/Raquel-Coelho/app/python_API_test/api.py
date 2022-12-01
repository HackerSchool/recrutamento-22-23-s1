from random import *
from email.message import EmailMessage
import ssl
import smtplib
import json
from flask import Flask, jsonify, request
from flask_cors import CORS
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


app = Flask(__name__)
CORS(app)

people = []

def send_email(mail, receiver, name):
    email_sender = 'secretsantaproject22@gmail.com'
    email_password = 'ginimvoopzersoir'
    email_receiver = mail

    

    subject = 'Secret Santa'
    body = f"""
    Hi! you give to {receiver}!
    """
    msg = MIMEMultipart("alternative")
    msg['Subject'] = subject
    msg['From'] = email_sender
    msg['To'] = email_receiver

    html_txt = f"""
    <html>
        <head></head>
        <body>
            <h1> Secret Santa 2022</h1>
            <p>Hey {name}!<br>
                You give to {receiver}! <br><br>
                Thanks for playing :)
            </p>
        </body>
    </html>
    """
    text_msg = MIMEText(html_txt, 'html')
    msg.attach(text_msg)

    # em = EmailMessage()
    # em['From'] = email_sender
    # em['To'] = email_receiver
    # em['Subject'] = subject
    # em.set_content(body)

    context = ssl.create_default_context()

    with smtplib.SMTP_SSL('smtp.gmail.com', 465, context=context) as smtp:
        smtp.login(email_sender, email_password)
        smtp.sendmail(email_sender, email_receiver, msg.as_string())


@app.route("/add-person", methods=["POST","GET"])
def add_person():
    output = request.get_json(force = True)
    people.append(output)
    print(people)
    return jsonify(output)

@app.route("/delete-person/<string:index>", methods=["DELETE"])
def remove_person(index):
    people.pop(int(index))
    print(people)
    return jsonify(people)

@app.route("/delete-all", methods=["DELETE"])
def delete_all():
    people.clear()
    print(people)
    return jsonify(people)


@app.route("/call-santa", methods=["DELETE"])
def secret_santa():
    shuffle(people)
    givers = people
    receivers = []
    for i in range(len(people)):
        receivers += [people[(i+1)%(len(people))]['name']]
    for i in range(len(people)):
        sendto = givers[i]['mail']
        sendto_name = givers[i]['name']
        send_email(sendto, receivers[i], sendto_name)
    return jsonify(receivers)


if __name__ == '__main__':
    app.run(debug=True,port=2000)
        