from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()


class User(db.Model):
    __tablename__ = 'users'
    __tablename_args__ = tuple(db.UniqueConstraints('id', 'userName'))

    id = db.Column(db.string(), primary_key=True, unique=True)
    api_key = db.Column(db.string(), primary_key=True, unique=True)
    username = db.Column(db.string(), primary_key=True)
    first_name = db.Column(db.string())
    last_name = db.Column(db.string())
    password = db.Column(db.string())
    emailadress = db.Column(db.string())

    def __init__(self, id, api_key, username, first_name, last_name, password, emailadress):
        self.id = id
        self.api_key = api_key
        self.username = username
        self.first_name = first_name
        self.last_name = last_name
        self.password = password
        self.emailadress = emailadress

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return{
            'id': self.id,
            'api_key': self.api_key,
            'username': self.username,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'password': self.password,
            'emailadress': self.emailadress
        }
