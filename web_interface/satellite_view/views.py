from django.http import HttpResponse
from django.shortcuts import render
import psycopg2
import os

def home(request):
    """ Exemple de page non valide au niveau HTML pour que l'exemple soit concis """
    return HttpResponse("""
        <h1>Bienvenue sur mon blog !</h1>
        <p>Les crêpes bretonnes ça tue des mouettes en plein vol !</p>
    """)


def retrieve_db(database, key, satellite_id):
    # Getting environment variables
    host = os.getenv('DATABASE_IP')
    user = os.getenv('DATABASE_USER')
    password = os.getenv('DATABASE_PASSWORD')
    port = os.getenv('DATABASE_PORT')

    # Using environment variables to connect to the database
    conn = psycopg2.connect(
    host=host,
    database=database,
    user=user,
    password=password,
    port=port)
        
    # create command
    command = "SELECT {} FROM {} WHERE satId='{}'".format(key, 'sat_details', satellite_id)

    # create a cursor
    cur = conn.cursor()

    # execute a statement
    cur.execute(command)
        
    # display the PostgreSQL answer
    db_answer = cur.fetchone()
    if(db_answer is not None):
        db_answer = db_answer[0]

    # close the communication with the PostgreSQL
    cur.close()

    # return answer
    return db_answer


def get_satellite_databases(request):
    
    if request.method == "POST":
        satellite_id = request.POST['satellite_id']
    else:
        satellite_id = '0'

    databases = ['honest_node_1', 'honest_node_2', 'honest_node_3', 'bad_node_1']

    sat_details_keys = ['name', 'nationality', 'apogee', 'perigee', 'inclination', 'launchDate']

    command = "SELECT {} FROM {} WHERE satId='{}'".format('{}', 'sat_details', satellite_id)
    
    sat_details = {}

    for database in databases:
        sat_details[database] = {}
        
        for key in sat_details_keys:
            sat_details[database][key] = retrieve_db(database, key, satellite_id)


    return render(request, 'satellite_view/satellite_databases.html', locals())

def satellite_demo(request):

    return render(request, 'satellite_view/satellite_demo.html', locals())

