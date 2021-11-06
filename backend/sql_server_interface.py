from packages.dotenv import dotenv_values
from packages.mysql import connector

def connect():
    config = dotenv_values(".env")
    return connector.connect(user=config["USER"], password=config["PASSWORD"],
                            host=config["HOST"],
                            database='StudyHelperDatabase')

def getInfo(cnx, email):
    cursor = cnx.cursor()
    cursor.execute("SELECT hash, salt, data FROM StudyHelperUsers "
                    "WHERE email = %s", (email,))

    res = None
    for (hash, salt, data) in cursor:
        res = {"email": email, "hash": hash, "salt": salt, "data": data}

    cursor.close()
    return res    
    

def updateInfo(cnx, email, hash, salt, data):
    # make sure exists
    if not getInfo(cnx, email):
        return False

    cursor = cnx.cursor()
    cursor.execute("UPDATE StudyHelperUsers SET hash = %s WHERE email = %s;", (hash, email))
    cursor.execute("UPDATE StudyHelperUsers SET salt = %s WHERE email = %s;", (salt, email))
    cursor.execute("UPDATE StudyHelperUsers SET data = %s WHERE email = %s;", (data, email))
    cursor.execute("UPDATE StudyHelperUsers SET email = %s WHERE email = %s;", (email, email))
    cnx.commit()
    cursor.close()
    return True

def deleteUser(cnx, email):
    # make sure exists
    if not getInfo(cnx, email):
        return False
    
    cursor = cnx.cursor()
    cursor.execute("DELETE FROM StudyHelperUsers WHERE email = %s", (email,))
    cnx.commit()
    cursor.close()
    return True

def createUser(cnx, email, hash, salt, data):
    # make sure doesn't exist
    if getInfo(cnx, email):
        return False

    cursor = cnx.cursor()
    cursor.execute("INSERT INTO StudyHelperUsers (email, hash, salt, data) "
                "VALUES (%s, %s, %s, %s);", (email, hash, salt, data))
    cnx.commit()
    cursor.close()
    return True

# example usage
# cnx = connect()
# print(getInfo(cnx, "email"))
# print(createUser(cnx, "email", "hash", "salt", "data"))
# print(getInfo(cnx, "email"))
# print(createUser(cnx, "email", "hash", "salt", "data"))
# print(updateInfo(cnx, "email", "hash2", "salt", "data"))
# print(getInfo(cnx, "email"))
# print(deleteUser(cnx, "email"))