from flask_restful import Resource
from flask import request
from models import db, Task


class task(Resource):
    def get(self):
        header_data = request.headers
        api_key = header_data.get("api_key")
        task = Task.query.all()
        print(task)
        temp = []
        for i in range(len(task)):
            dummy = task[i].serialize()
            if dummy["api_key"] == api_key:
                temp.append({'task': dummy["task"], 'status': dummy["status"]})
        return {"message": "Task for {}".format(api_key), "task": temp}

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

    def delete(self):
        json_data = request.headers
        print(json_data)
        task = Task(
            api_key=json_data.get("api_key"),
            task=json_data.get("task"),
            status=json_data.get("status")
        )
        Task.query.filter_by(task=json_data['title']).delete()
        # db.session.filter_by(task=json_data.get("title")).delete()
        #  db.session.delete(task)
        db.session.commit()
        print("done")

        return {"status": 'success', 'task_added': True}, 200
