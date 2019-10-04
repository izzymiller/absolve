Absolve: A Looker carbon offset solution
====================================
This document explains Absolve at a high level and how to install it. There are individual READMEs in the subfolders that explain the contents in further detail.

For support or questions about absolve, feel free to tweet @isidoremiller or open an issue in the repo.

# What is Absolve?

Absolve is a three part tool composed of a Looker block, a Looker action, and a Google Cloud Function. Together, it lets you:
- Visualize your company's carbon footprint using a Looker dashboard
- Purchase carbon offsets directly from that dashboard
- Visualize those offsets in real time, on the same dashboard.

It was created based on an ecommerce dataset, and calculates the carbon emissions of shipping orders from distribution centers to user locations. No factors are taken into consideration besides:
-Item weight
-Item distance shipped
-Item shipping method

I would love for it to one day include more robust CO2e calculations— PR welcome!

# Installation
Installation is designed to be as easy as possible, but still requires a couple of steps. 

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
5. Redeploy your action hub— You're good to go!


## Setting up the Looker Block

## Setting up the Google Cloud Function


# C02 Calculations

# Carbon Offsets
