# Create Resource Group
az group create --name myResourceGroup --location eastus

# Create 3 container instances 
for((i=0; i<3, ++i)); do az container create --resource-group myResourceGroup --name mycontainer$i --image mcr.microsoft.com/azuredocs/aci-helloworld --ip-address public; done

# Fetch all the container lists
az container list

# Fetch all the container lists in to table
az container list --output table

az container show -n mycontainer0 -g myResourceGroup --query name --output table
az container list --query [].name --output table
az container list --query [].[name,location] --output table
az container list --query "[].{Name:name,Location:location}" --output table
