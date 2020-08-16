from flask_restful import Resource
from flask import request
from models import db, Task


class task(Resource):
    def get(self):
        header_data = request.headers
        api_key = header_data.get("api_key")
        task = Task.query.all()
        temp = []
        for val in temp:
            if val["api_key"] == api_key and val["status"] != "done":
                temp.append(val["task"])
        return {"message": "Task for {}".format(api_key), "task": task}

    def post(self):
        json_data = request.headers

        task = Task(
            api_key=json_data.get("api_key"),
            task=json_data.get("task"),
            status=json_data.get("status")
        )
        db.session.add(task)
        db.session.commit()

        return {"status": 'success', 'task_added': True}, 200
