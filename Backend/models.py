from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()


class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer(), primary_key=True)
    api_key = db.Column(db.String(), unique=True)
    username = db.Column(db.String())
    firstname = db.Column(db.String())
    lastname = db.Column(db.String())
    password = db.Column(db.String())
    emailadress = db.Column(db.String())

    def __init__(self, firstname, lastname, emailadress, password, username, api_key):
        self.firstname = firstname
        self.lastname = lastname
        self.emailadress = emailadress
        self.password = password
        self.username = username
        self.api_key = api_key

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return{
            'username': self.username,
            'firstname': self.firstname,
            'lastname': self.lastname,
            'password': self.password,
            'emailadress': self.emailadress,
            'api_key': self.api_key
        }


class Task(db.Model):
    __tablename__ = 'tasks'

    id = db.Column(db.Integer(), primary_key=True)
    api_key = db.Column(db.String())
    task = db.Column(db.String())
    status = db.Column(db.String())

    def __init__(self, api_key, task, status):
        self.api_key = api_key
        self.task = task
        self.status = status

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return{
            'api_key': self.api_key,
            'task': self.task,
            'status': self.status
        }
