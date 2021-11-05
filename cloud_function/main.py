from offset_utils import upload_blob,create_dataset,create_table,load_data,pull_data
import flask
from flask import abort
import requests

def refresh_offset_data(request):
    """Get vars from request"""
    request_json = request.get_json()
    if request_json and 'bucketName' in request_json and 'datasetId' in request_json and 'tableId' in request_json: 
        bucketName = request_json['bucketName']
        datasetId = request_json['datasetId']
        tableId = request_json['tableId']
    else:
        abort(401) 
    
    """Get data from cloverly"""
    sourceFilePath = pull_data()
    print('Data successfully pulled from Cloverly')

    """Upload and import data"""
    try:
        fileUri = upload_blob(bucketName,sourceFilePath,'offset_data.json')
        print('Data successfully uploaded to GCS')
    except:
        return 'Error uploading data to GCS'
    try:
        create_dataset(datasetId)
        print("New dataset successfully created")
    except:
        return 'Error creating new BQ Dataset'
    try:
        create_table(datasetId,tableId)
        print("New table successfully created")
    except:
        return 'Error creating new Table'
    try:
        load_data(datasetId,tableId,fileUri)
        return "Offset data successfully refreshed in your DB"
    except:
        return 'Error loading data into BigQuery'