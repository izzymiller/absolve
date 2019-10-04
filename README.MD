Absolve: A Looker carbon offset solution
====================================
This document explains Absolve at a high level and how to install it.

For support or questions about absolve, feel free to tweet @isidoremiller or open an issue in the repo.

# What is Absolve?



Absolve is a three part tool composed of a Looker block, a Looker action, and a Google Cloud Function. Together, it lets you:
- Visualize your company's carbon footprint using a Looker dashboard
- Purchase carbon offsets directly from that dashboard (using [Cloverly](https://cloverly.com)!)
- Visualize those offsets in real time, on the same dashboard.

<p align="center">
  <img src="https://i.imgur.com/wsRON1j.png" />
</p>

It was created based on an ecommerce dataset, and calculates the carbon emissions of shipping orders from distribution centers to user locations. No factors are taken into consideration besides:
-Item weight
-Item distance shipped
-Item shipping method

I would love for it to one day include more robust CO~2~e calculations— PR welcome!

# Installation
Installation is designed to be as easy as possible, but still requires a lot of steps. I'm working on a way to make it more packaged and palatable.

## Action Hub
A key component of absolve is the Action. For a high-level take on data actions, head to the [Looker Docs](https://looker.com/platform/actions). Essentially, they're a user-friendly way to send a webhook from Looker to a predetermined destination, with predefined form fields to facilitate some kind of... action! 

We'll actually be actually deploying a custom action hub in order to run this action. If you already have a custom action hub set up, then installing absolve is simple and you can skip to the "Installing the absolve action" subsection.
**If you do not want to do this yourself, you can clone [this repo](https://github.com/izzymiller/absolve_action_hub) and deploy an action hub running just absolve without editing anything.**

### Deploying a custom action hub
Check out the official Looker guide to deploy a custom action hub [here](https://github.com/looker/actions/blob/master/docs/deploying.md).
Make sure to generate an API key, add it to Looker, and ensure that Looker can talk to the action hub.

### Installing the Absolve action
0. Download or clone this repository
1. Enter your actions root directory (`cd /actionhub`)
2. Create a new directory for absolve (`mkdir src/actions/absolve`)
3. Place absolve.ts, test_absolve.ts, and leaf.svg from the downloaded `absolve/action` directory into the `/actionhub/src/actions/absolve` directory. I'm a chump so I do this in the UI
4. Edit `/actions/src/actions/index.ts` to include a line `import "./absolve/absolve"`
5. Redeploy your action hub. Now in the Looker Admin Panel > Actions, you should see the "Absolve" action appear under your custom action hub section.
![Settings](https://i.imgur.com/2xeie5V.png)
6. Open the settings of the Absolve action and fill them out:
- Cloverly API Private Key: For this, you'll need to visit [cloverly.com](https://cloverly.com) and sign up for an account. Generate some API keys and add billing info if you want to actually start purchasing offsets. Enter your private API key here (it's secure!)
- Use data pipeline: If you plan to install the cloud function and pipe data from cloverly back into Looker, type "yes" into this setting.
- GCS bucket name: If you have selected "yes" for the data pipeline, you must provide the name of a Google Cloud Storage bucket that you'd like to use to write offset data to. The default is "carbon_bucket".
- BQ DatasetID: If you have selected "yes" for the data pipeline, you must provide the name of a Bigquery Dataset where the offset data will be stored and queried from. The default is "offset_purchases".
- BQ Table Name: If you have selected "yes" for the data pipeline, you must provide the name of a Bigquery table where you'd like the offset data to live. The default is "purchases".

7. Save your settings and test the action hub! If you see "Action is configured correctly!", then you're in business and can move onto the LookML portion of the setup.

## Setting up the Google Cloud Function
Once you're all set up with the block, it's time to set up the Google Cloud Function that pipes offset information back to the DB. This is the module that speaks to [Cloverly](https://cloverly.com) and pushes the data back into Bigquery.

This module is entirely optional— But you won't be able to visualize your offset information in Looker without it. 

To set it up, you'll need to:

0. Assuming you've cloned this repo if you haven't already
1. Create a Google Cloud Storage bucket (I named mine carbon_bucket)
2. Add that bucket name to the action settings from the Looker admin panel 
3. Create a Bigquery dataset (I named mine offset_purchases) and add that to the action settings.
4. Make sure to add the Bigquery connection the offset_purchases dataset is in to Looker, if it's not already. [Here are the Looker docs on connecting to BQ](https://docs.looker.com/setup-and-management/database-config/google-bigquery). You'll want to edit the 
3. Install the gcloud SDK: https://cloud.google.com/sdk/install
4. Navigate to the cloud_function directory (`cd absolve/cloud_function`)
5. Deploy the cloud function. Using the MacOS gcloud SDK, I run ```gcloud beta functions deploy refresh_offset_data --runtime python37 --trigger-http --set-env-vars CL_PRIVATE_KEY=<your_cloverly_private_key_here>```
6. The CLI will prompt you that it is "Deploying function (may take a while - up to 2 minutes)". Once it completes, you should see a whole mess of information including `status: ACTIVE`. This lets you know that deployment has succeeded and the cloud function is eagerly waiting to receive data.

## Setting up the Looker Block
All of the LookML from the `block` subdirectory can be dragged and dropped into a new project in Looker. I've tried to standardize all field names, but you should go through them to make sure they match your database setup. **If you already have a model built out for your business, I recommend exclusively importing the carbon_cruncher.view.lkml, offset.view.lkml, and offsets.model.lkml files, and then integrating carbon_cruncher into your existing explores using absolve.model.lkml as a template.** There is a sample LookML dashboard in the directory (`business_pulse.dashboard.lkml`), but you may instead want to add tiles to existing dashboards using that as a template. 

**Things you will need to change**
- In carbon_cruncher.view.lkml, there is a derived table that will require manual updating to match your database setup. I'm working on making this simpler.
- In offset.model.lkml, you'll need to edit the `connection` to reference your bigquery connection set up in step 4 above.
- For carbon_cruncher.view.lkml to function, a shipping_method and a product_weight are required. The current product_weight setup is in lbs, but you can edit as you see fit— Just make sure to also alter the ton conversions accordingly. The product_weight field is the individual weight of each product in your inventory.
- Each view's sql_table_name parameter on line 2 will require manual updating to match your database setup

If you've installed this properly, you should be able to run queries on your carbon footprint by adding the CO~2~e Footprint (kg) measure to any query. That field (and any field tagged ["co2_footprint"] can be clicked on to activate the Absolve action and purchase offsets. Once you start purchasing offsets, you'll start seeing that purchase information displayed on the same dashboard. 
![Absolve Form](https://i.imgur.com/wSQGmw9.png)



# C0~2~ Calculations
The carbon coefficients used to calculate emissions by freight type are sourced from the UK Government's [2019 emission conversion factor publication](https://www.gov.uk/government/collections/government-conversion-factors-for-company-reporting).  The full document is available for review at that link (big ol spreadsheets!) but when generalized (and I did generalize, heavily) it comes out to:
Air Freight: 1.23205 kg Co~2~e per Ton-mile
Truck Freight: 0.11360 kg Co~2~e per ton-mile
Boat Freight: 0.01614 kg Co~2~e per Ton-mile
Yes, I know those units are preposterous. [The EDF uses them too](http://business.edf.org/blog/2015/03/24/green-freight-math-how-to-calculate-emissions-for-a-truck-move). It just means how many kg of Co~2~e are emitted to carry one ton of freight one mile.



# Carbon Offsets
Carbon offsets aren't perfect. Many would argue that they're useless and only serve to enable polluting behavior. I sit in a sort of in-between camp. [This article from Yale Climate Connections](https://www.yaleclimateconnections.org/2019/05/are-carbon-offsets-a-scam/) sums up my feelings pretty well— "It depends". I chose to use [Cloverly](https://cloverly.com) for this project. I hope they evaluate their choice of offsets carefully and purchase offsets that are real, ethical, and impactful.

You should always first reduce your impact. Offsets are supposed to be for the last little bit of the way that you couldn't get. Honestly, I feel that the power of this tool is less in the actual action taken, and more in the progress towards sustainable mindsets that it helps foster. If an organization installs absolve and gets used to seeing their carbon footprint as an integral part of their daily ecommerce dashboard, they will act more sustainably throughout their entire business. If they get used to using Looker to offset the small percentage of orders that max out a certain threshold, they'll take that into consideration when they see it offline. Change is incremental. Offsets can certainly be a driver of laziness— But I prefer to think of them as palatable motivators towards sustainable mindsets.
