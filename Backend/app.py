from flask import Blueprint
from flask_restful import Api
from resources.Register import Register
from resources.task import task

api_bp = Blueprint('api', __name__)
api = Api(api_bp)

# Route
api.add_resource(Register, '/Register')
api.add_resource(task, '/task')
