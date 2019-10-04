This is the module that speaks to [Cloverly](https://cloverly.com) and pipes the data back into Bigquery.

This module is entirely optional— But you won't be able to visualize your offset information in Looker without it. 

To set it up, you'll need to:

1. Create a Google Cloud Storage bucket (I named mine carbon_bucket)
2. Add that bucket name to the action settings from the Looker admin panel 
3. Install the gcloud SDK: https://cloud.google.com/sdk/install
4. Deploy the cloud function. Using the MacOS gcloud SDK, I run ```gcloud beta functions deploy refresh_offset_data --runtime python37 --trigger-http --set-env-vars CL_PRIVATE_KEY=<your_cloverly_API_key_here>```

