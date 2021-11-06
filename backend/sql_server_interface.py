from packages.dotenv import dotenv_values
from packages.mysql import connector

config = dotenv_values(".env")

print(config)


cnx = connector.connect(user=config["USER"], password=config["PASSWORD"],
                        host=config["HOST"],
                        database='StudyHelperDatabase')
cnx.close()

print("done")