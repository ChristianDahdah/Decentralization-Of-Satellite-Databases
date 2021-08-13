from django.http import HttpResponse
from django.shortcuts import render
import psycopg2
import os
from web3 import Web3

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
    
    satDetails_address = os.getenv("SATDETAILS_ADDRESS")
    # oracle_address = os.getenv("ORACLE_ADDRESS")
    
    infura_url = os.getenv("INFURA_URL")

    return render(request, 'satellite_view/satellite_demo.html', locals())


# Getting actual block number
def get_block_number(request):
    
    infura_url = os.getenv("INFURA_URL")
    
    w3 = Web3(Web3.HTTPProvider(infura_url))
    
    block_number = str(w3.eth.block_number)

    return render(request, 'satellite_view/get_block_number.html', locals())

# Getting responses
def get_responses(request):

    infura_url = os.getenv("INFURA_URL")

    w3 = Web3(Web3.HTTPProvider(infura_url))


