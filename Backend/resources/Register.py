from flask_restful import Resource
from flask import request
from models import db, User


class Register(Resource):
    def get(self):
        users = User.query.all()
        user_list = []
        for i in range(len(users)):
            user_list.append(users[i].serialize())
        return {"Status": "Sucess", "data": user_list}, 200

    def post(self):
        json_data = request.get_json(force=True)

        if not json_data:
            return {'message': 'No input data provided'}, 400
        # Validate and deserialize input

        user = User.query.filter_by(username=json_data['username']).first()
        emailadress = User.query.filter_by(
            emailadress=json_data['emailadress']).first()
        if user:
            return {'message': 'Username already exists'}, 400

        if emailadress:
            return {'message': 'Email already registered'}, 400

        user = User(
            firstname=json_data["firstname"],
            lastname=json_data["lastname"],
            emailadress=json_data["emailadress"],
            password=json_data["password"],
            username=json_data["username"]
        )

        db.session.add(user)
        db.session.commit()

        result = User.serialize(user)

        return {"status": 'success', 'data': result}, 201
