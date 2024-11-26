#!/bin/bash

az deployment group create --resource-group az104-rg3 --template-file template.json --parameters parameters.json

az disk list --output table

az deployment group create --resource-group az104-rg3 --template-file ./deploydisk.bicep

az group delete --resource-group az103-rg3 --yes