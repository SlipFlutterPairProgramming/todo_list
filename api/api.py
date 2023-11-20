import json
from collections import defaultdict, namedtuple
import asyncio

from fastapi import FastAPI
from pydantic import BaseModel


class TodoItem(BaseModel):
    uuid: str
    category: str
    content: str
    favorite: bool = False
    done: bool = False

class DB:
    def __init__(self):
        self.file_name: str = "local.db"
        try:
            with open(self.file_name, "r") as fp:
                self.db: defaultdict[TodoItem] = defaultdict(json.load(fp))
        except:
            self.db: defaultdict[TodoItem] = defaultdict(list)

    def save_db(self):
        async def _save_db():    
            with open(self.file_name, "w") as fp:
                json.dump(dict(self.db), fp)
        asyncio.create_task(_save_db()).add_done_callback(lambda _: print("db saved"))

    def get(self, dev_id: str)->list[dict]:
        return self.db[dev_id]

    def put(self, dev_id: str, todo_item: TodoItem):
        self.delete(dev_id, todo_item.uuid)
        self.db[dev_id].append(dict(todo_item))
        self.save_db()
    
    def delete(self, dev_id:str, uuid:str) -> bool:
        tgt = [ti for ti in self.db[dev_id] if ti['uuid'] == uuid]
        if tgt:
            self.db[dev_id].remove(tgt[0])
            return True
        return False        

db = DB()
app = FastAPI()

@app.post("/{dev_id}/get")
async def get_todos(dev_id: str):
    return {"dev_id": dev_id, "todos": db.get(dev_id)}

@app.post("/{dev_id}/put")
async def put_todo(dev_id: str, todo_item:TodoItem):
    db.put(dev_id, todo_item)
    return {"dev_id": dev_id, "todos": db.get(dev_id)}

@app.post("/{dev_id}/delete")
async def delete_todo(dev_id: str, uuid:str):
    success = db.delete(dev_id, uuid)
    return {"dev_id": dev_id, 'success': success,"todos": db.get(dev_id)}

