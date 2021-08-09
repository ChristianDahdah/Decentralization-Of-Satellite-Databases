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


def retrieve_db(database, key, satId):
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
    command = "SELECT {} FROM {} WHERE satId='{}'".format(key, 'sat_details', satId)

    # create a cursor
    cur = conn.cursor()

    # execute a statement
    print('Retrieving data from postgres server:')
    cur.execute(command)
        
    # display the PostgreSQL answer
    db_answer = cur.fetchone()[0]  # cur.fetchone() or in the SELECT I can filter: SELECT * FROM table WITH col1=value;

    # close the communication with the PostgreSQL
    cur.close()

    # return answer
    return db_answer


def satellite_view(request):
    
    satId = 2

    databases = ['honest_node_1', 'honest_node_2', 'honest_node_3', 'bad_node_1']

    sat_details_keys = ['nationality', 'name', 'apogee', 'perigee', 'inclination', 'launchDate']

    command = "SELECT {} FROM {} WHERE satId='{}'".format('{}', 'sat_details', satId)
    
    sat_details = {}

    for database in databases:
        sat_details[database] = {}
        
        for key in sat_details_keys:
            sat_details[database][key] = retrieve_db(database, key, satId)


    return render(request, 'satellite_view/satellite_info.html', locals())
