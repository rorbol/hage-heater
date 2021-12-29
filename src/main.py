# install dependencies with: pip install requests sanction
import os
import requests
import sanction


# replace with your client ID (see Adax WiFi app,Account Section)
CLIENT_ID = os.environ.get('CLIENT_ID')
CLIENT_SECRET = os.environ.get('CLIENT_SECRET')
API_URL = os.environ.get('API_URL') #"https://api-1.adax.no/client-api"

def get_token():
  # Authenticate and obtain JWT token
  oauthClinet = sanction.Client(token_endpoint = API_URL + '/auth/token')
  oauthClinet.request_token(grant_type = 'password', username = CLIENT_ID, password = CLIENT_SECRET)
  return oauthClinet.access_token

def set_room_target_temperature(roomId, temperature, token):

  # Sets target temperature of the room
  headers = { "Authorization": "Bearer " + token }
  json = { 'rooms': [{ 'id': roomId, 'targetTemperature': str(temperature) }] }
  requests.post(API_URL + '/rest/v1/control/', json = json, headers = headers)

def get_homes_info(token):

  headers = { "Authorization": "Bearer " + token }
  response = requests.get(API_URL + "/rest/v1/content/", headers = headers)

  json = response.json()

  for room in json['rooms']:

    roomName = room['name']
    targetTemperature = room['targetTemperature'] / 100.0
    currentTemperature = 0

  if ('temperature' in room):
    currentTemperature = room['temperature'] / 100.0

  print("Room: %15s, Target: %5.2fC, Temperature: %5.2fC, id: %5d" % (roomName, targetTemperature, currentTemperature, room['id']))

def handler(event, context):
  token = get_token()

  # Change the temperature to 24 C in the room with an Id of 196342
  # set_room_target_temperature(196342, 2400, token)

  # Replace the 196342 with the room id from the
  # get_homes_info output
  get_homes_info(token)