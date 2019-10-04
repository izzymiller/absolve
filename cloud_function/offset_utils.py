from google.cloud import bigquery
from google.cloud import storage
import subprocess
import json
import requests
import pandas as pd
import os

##Upload file

def upload_blob(bucketName, sourceFile, destinationName):
    """upload a CSV to a bucket"""
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucketName)
    blob = bucket.blob(destinationName)
    blob.upload_from_filename(sourceFile)
    uri = 'gs://{}/{}'.format(bucketName,destinationName)
    print('File {} uploaded to bucket {}/{}'.format(sourceFile,bucketName,destinationName))
    return uri


## Spin up dataset and table if not existing

def create_dataset(datasetId):
    bq_client = bigquery.Client()
    dataset_ref = bq_client.dataset(datasetId)
    try:
        bq_client.get_dataset(dataset_ref)
        print('Dataset {} already exists'.format(datasetId))
    except:
        dataset = bigquery.Dataset(dataset_ref)
        dataset = bq_client.create_dataset(dataset)
        print('Dataset {} created.'.format(dataset.dataset_id))

def create_table(datasetId,tableId):
    bq_client = bigquery.Client()
    dataset_ref = bq_client.dataset(datasetId)
    # Prepares a reference to the table
    table_ref = dataset_ref.table(tableId)
    try:
        bq_client.get_table(table_ref)
    except:
        schema = [bigquery.SchemaField('slug', 'STRING', mode='REQUIRED'),bigquery.SchemaField('environment', 'STRING', mode='REQUIRED')
        ]
        table = bigquery.Table(table_ref, schema=schema)
        table = bq_client.create_table(table)
        return 'table {} created.'.format(table.table_id)

def load_data(datasetId,tableId,uri):
    bq_client = bigquery.Client()
    dataset_ref = bq_client.dataset(datasetId)
    job_config = bigquery.LoadJobConfig()
    job_config.autodetect = True
    job_config.source_format = bigquery.SourceFormat.NEWLINE_DELIMITED_JSON
    job_config.write_disposition = bigquery.WriteDisposition.WRITE_TRUNCATE
    
    load_job = bq_client.load_table_from_uri(uri, dataset_ref.table(tableId), location="US", job_config=job_config)
    print("Starting job {}".format(load_job.job_id))
    load_job.result()
    print("Job finished.")
    destination_table = bq_client.get_table(dataset_ref.table(tableId))
    print("Loaded {} rows.".format(destination_table.num_rows))


def pull_data():
    """Pulls data out of cloverly's Purchases endpoint and formats it for upload to Bigquery"""
    url = 'https://api.cloverly.app/2019-03-beta/purchases'
    headers = {'Content-type': 'application/json', 'Authorization': 'Bearer private_key:{}'.format(os.environ.get('CL_PRIVATE_KEY'))}
    r = requests.get(url, headers=headers)
    purchase_data = r.json()
    for element in purchase_data:
        """This step is annoyingly necessary because BQ does not like empty arrays, and Cloverly returns an empty array here"""
        del element['renewable_energy_certificate']['deprecated']
    """This is the ONLY fucking way I could figure out how to get NL delimited JSON out of python. Jeez"""    
    df = pd.read_json(json.dumps(purchase_data))
    filePath = '/tmp/purchase_data.json'
    df.to_json(filePath,orient='records',lines=True)
    return filePath







