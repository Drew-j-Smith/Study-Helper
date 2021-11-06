import json
from hmac import compare_digest
import sql_server_interface

def lambda_handler(event, context):
    method = event["requestContext"]["http"]["method"]
    if method == "GET":
        return {
            "statusCode": 200,
            "body": "running"
        }
    if method == "PUT":
        return put(event)
    if method == "POST":
        return post(event)
    if method == "DELETE":
        return delete(event)
    
    return error(f"{method} operation is not permited")

def put(event):
    body = json.loads(event["body"])
    for field in ["email", "hash", "salt", "data"]:
        if field not in body:
            return error(f"Must supply {field}")
    cnx = sql_server_interface.connect()
    info = sql_server_interface.getInfo(cnx, body["email"])
    if info:
        cnx.close()
        return error("User already exists")
    sql_server_interface.createUser(cnx, body["email"], body["hash"], body["salt"], body["data"])
    cnx.close()
    return {
        "statusCode": 201,
        "body": "success"
    }

def post(event): 
    res = {}
    body = json.loads(event["body"])
    if "email" not in body:
        return error("Must supply email")
    
    cnx = sql_server_interface.connect()
    info = sql_server_interface.getInfo(cnx, body["email"])

    if not info:
        cnx.close()
        return error("User does not exist")
    
    if "hash" in body:
        # validate
        if not compare_digest(body["hash"], info["hash"]):
            cnx.close()
            return error("Invalid password")
        
        # test for updates
        for field in ["email", "hash", "salt", "data"]:
            if field in body and body[field] != info[field]:
                sql_server_interface.updateInfo(cnx, body[email], field, body[field])

        res = sql_server_interface.getInfo(cnx, body["email"])
    else:
        # resturn salt
        res = { "salt": info["salt"] }

    cnx.close()
    return {
        "statusCode": 200,
        "body": json.dumps(res)
    }

def delete(event):
    body = json.loads(event["body"])
    if "email" not in body or "hash" not in body:
        return error("Must supply email and hash")
    
    cnx = sql_server_interface.connect()
    info = sql_server_interface.getInfo(cnx, body["email"])

    if not info:
        cnx.close()
        return error("User does not exist")
    
    # validate
    if not compare_digest(body["hash"], info["hash"]):
        cnx.close()
        return error("Invalid password")

    res = sql_server_interface.deleteUser(cnx, body["email"])

    cnx.close()
    return {
        "statusCode": 200,
        "body": "success"
    }

def error(msg):
    return {
        "statusCode": 400,
        "body": msg
    }