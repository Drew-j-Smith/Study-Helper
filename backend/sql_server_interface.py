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
                    f"WHERE email = \"{email}\";")

    res = None
    for (hash, salt, data) in cursor:
        res = (hash, salt, data)

    cursor.close()
    return res    
    

def updateInfo(cnx, email, field, newValue):
    # make sure exists
    if not getInfo(cnx, email):
        return False;

    cursor = cnx.cursor()
    cursor.execute(f"UPDATE StudyHelperUsers SET {field} = \"{newValue}\" "
                    f"WHERE email = \"{email}\";")
    cnx.commit()
    cursor.close()
    return True

def deleteUser(cnx, email):
    # make sure exists
    if not getInfo(cnx, email):
        return False;
    
    cursor = cnx.cursor()
    cursor.execute(f"DELETE FROM StudyHelperUsers WHERE email = \"{email}\";")
    cnx.commit()
    cursor.close()
    return True

def createUser(cnx, email, hash, salt, data):
    # make sure doesn't exist
    if getInfo(cnx, email):
        return False;

    cursor = cnx.cursor()
    cursor.execute("INSERT INTO StudyHelperUsers (email, hash, salt, data) "
                f"VALUES (\"{email}\", \"{hash}\", \"{salt}\", \"{data}\");")
    cnx.commit()
    cursor.close()
    return True

# example usage
# cnx = connect()
# print(getInfo(cnx, "email"))
# print(createUser(cnx, "email", "hash", "salt", "data"))
# print(getInfo(cnx, "email"))
# print(createUser(cnx, "email", "hash", "salt", "data"))
# print(updateInfo(cnx, "email", "hash", "hash2"))
# print(getInfo(cnx, "email"))
# print(deleteUser(cnx, "email"))