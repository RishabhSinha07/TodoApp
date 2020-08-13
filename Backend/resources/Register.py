from flask_restful import Resource
from flask import request
from models import db, User

import random
import string


class Register(Resource):

    def get(self):

        header_data = request.headers
        emailadress = header_data.get("emailadress")
        password = header_data.get("password")

        if emailadress is None or password is None:
            return {"Status": "Failed", "user_found": False}, 400

        users = User.query.all()
        for i in range(len(users)):
            temp = users[i].serialize()
            if temp["emailadress"] == emailadress and temp["password"] == password:
                return {"Status": "Sucess", "user_found": True, "api_key": users[i].serialize()["api_key"]}, 200

        return {"Status": "Sucess", "user_found": False, "api_key": None}, 200

    def post(self):

        json_data = request.get_json(force=True)

        if not json_data:
            return {'message': 'No input data provided'}, 400

        user = User.query.filter_by(username=json_data['username']).first()
        emailadress = User.query.filter_by(
            emailadress=json_data['emailadress']).first()
        if user:
            return {'message': 'Username already exists'}, 400

        if emailadress:
            return {'message': 'Email already registered'}, 400

        api_key = self.generate_key()

        user = User.query.filter_by(api_key=api_key).first()

        if user:
            return {'message': 'Api key exist'}, 400

        user = User(
            firstname=json_data["firstname"],
            lastname=json_data["lastname"],
            emailadress=json_data["emailadress"],
            password=json_data["password"],
            username=json_data["username"],
            api_key=api_key
        )

        db.session.add(user)
        db.session.commit()

        # result = User.serialize(user)

        return {"status": 'success', 'user_created': user.serialize()}, 201

    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(20))
