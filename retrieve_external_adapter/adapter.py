import psycopg2
import os

class Adapter:

    def __init__(self, input):
        # Every call needs a job id
        self.id = input.get('id', '1')
        # Request we get from the smart contract or from chainlink node?
        self.request_data = input.get('data')
        # validate_request_data() validates if the request is in a good format
        if self.validate_request_data():
            # Take info from request_data to restructure and use it in our 3rd party API
            self.create_request()
        else:
            self.result_error('No data provided')
    

    # For example here the function checks if the request in empty or not
    def validate_request_data(self):
        if self.request_data is None:
            return False
        if self.request_data == {}:
            return False 
        
        self.satId = self.request_data.get('satId')
        print('satId: ' + self.satId)

        if (isinstance(int(self.satId), int)):
                return True
        
        return False


    # Function that helps retrieve information from postgres database
    def retrieveDB(self, command):
        # Getting environment variables
        host = os.getenv('DATABASE_IP')
        database = os.getenv('DATABASE_NAME')
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

        # create a cursor
        cur = conn.cursor()

        # execute a statement
        cur.execute(command)

        # display the PostgreSQL answer
        db_answer = cur.fetchone()[0] # cur.fetchone() or in the SELECT I can filter: SELECT * FROM table WITH col1=value;

        # close the communication with the PostgreSQL
        cur.close()

        # return answer
        return db_answer

    def intToHexStr(self, number, byte_size):
        # Making sure the number and the byte size are integers
        assert(isinstance(number, int) and isinstance(byte_size, int))
        # Maximum size of an argument is 32 bytes in Chainlink ethTx adapter
        assert(byte_size <= 32)

        # Encoding number as a hex and removing 0x at the beginning
        num_hex = hex(number)[2:]

        # Checking byte size and adding '0' accordingly
        while(len(num_hex) < byte_size * 2):
            num_hex = '0' + num_hex

        assert(len(num_hex) == byte_size*2)
        return num_hex

    def strToHexStr(self, string, byte_size):
        # Making sure the string is a string and the byte size are integers
        assert(isinstance(string, str) and isinstance(byte_size, int))
        # Maximum size of an argument is 32 bytes in Chainlink ethTx adapter
        assert(byte_size <= 32)
        # String length should be smaller or equal to byte size (1 character = 1 byte)
        assert(len(string) <= byte_size)

        while(len(string) < byte_size):
            string = string + ' '

        return string.encode("utf-8").hex()

    def buildHexResponse(self, response):
        assert (isinstance(response, str) and len(response) <= 32*2), "Argument 'response' not right correct"
        
        # Adding necessary '0' to the right to have 32 bytes
        while len(response) < 32*2:
            response = response + '0'

        # Adding initial padding
        response = '0x' + response
        return response
    

    def create_request(self):
        
        try:
            command = "SELECT {} FROM {} WHERE satId='{}'".format('{}', os.getenv('TABLE_NAME'), self.satId)

            nationality = self.retrieveDB(command.format('nationality'))
            nationality = self.strToHexStr(nationality, 4)
            
            name = self.retrieveDB(command.format('name'))
            name = self.strToHexStr(name, 12)
            
            apogee = self.retrieveDB(command.format('apogee'))
            apogee = self.intToHexStr(int(apogee), 4)
            
            perigee = self.retrieveDB(command.format('perigee'))
            perigee = self.intToHexStr(int(perigee), 4)

            inclination = self.retrieveDB(command.format('inclination'))
            inclination = self.intToHexStr(int(inclination), 4)

            launchDate = self.retrieveDB(command.format('launchDate'))
            launchDate = launchDate.strftime('%Y/%m/%d')
            launchDate = launchDate.replace('/', '')
            launchDate = self.intToHexStr(int(launchDate), 4)
            
            response = nationality + name + apogee + perigee + inclination + launchDate
            
            # This is optional, but in our case we want the length of the reply to be 32 bytes (64 characters in hex) even before the padding 
            assert len(response)==64, "reponse length different than 64 hex characters"

            response = self.buildHexResponse(response)

            self.result = response

            print(response)

            self.result_success(response)

        except Exception as e:
            print(e)
            self.result_error(e)

    def result_success(self, data):
        self.result = {
            'jobRunID': self.id,
            'data': data,
            'result': self.result,
            'statusCode': 200,
        }

    def result_error(self, error):
        self.result = {
            'jobRunID': self.id,
            'status': 'errored',
            'error': f'There was an error: {error}',
            'statusCode': 500,
        }
