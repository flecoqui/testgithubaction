
#!/bin/bash
##########################################################################################################################################################################################
#- Purpose: Script used to install pre-requisites, deploy/undeploy service, start/stop service, test service
#- Parameters are:
#- [-a] action - value: login, install, deploy, undeploy, createapp, buildfe, buildbe, deployfe, deploybe, deployev 
#- [-e] Stop on Error - by default false
#- [-s] Silent mode - by default false
#- [-d] Deployment type: 'web-app-api-cosmosdb', 'web-app-api-storage', 'web-storage-api-storage', 'eventhub', 'eventhub-asa' - by default 'web-storage-api-storage'
#- [-c] configuration file - which contains the list of path of each iactool.sh to call (configuration/default.env by default)
#- [-z] authorization disabled - Azure AD Authorization disabled for Web UI and Web API - by default false
#- [-k] service Plan Sku - Azure Service Plan Sku - by default B2  values: "B1","B2","B3","S1","S2","S3","P1V2","P2V2","P3V2","P1V3","P2V3","P3V3"
#- [-h] event Hub Sku - Event Hub Sku - by default Standard  values: "Basic","Standard","Premium"
#
# executable
###########################################################################################################################################################################################
set -eu
echo "Create Azure AD Application..."
#######################################################
#- function used to print out script usage
#######################################################
function usage() {
    echo
    echo "Arguments:"
    echo -e " -s  Sets Azure Subscription Id"
    echo -e " -t  Sets Azure AD Tenant Id "
    echo -e " -n  Sets Application Name"
    echo -e " -u  Sets Redirect Uri for the Web App"
    echo -e " -r  Sets Resource Group of the Storage Account"
    echo -e " -a  Sets Azure Storage Account Name where the video/frame will be uploaded/downloaded"

    echo
    echo "Example:"
    echo -e " bash ./createapp.sh -s 00000002-0000-0000-c000-000000000000 -t 00000002-0000-0000-c000-000000000000 -n spdevapp -u http://localhost:8000/ "
    
}
# shellcheck disable=SC2034
parent_path=$(
    cd "$(dirname "${BASH_SOURCE[0]}")/../../"
    pwd -P
)
# Read variables in configuration file
SCRIPTS_DIRECTORY=$(dirname "$0")
##############################################################################
# colors for formatting the ouput
##############################################################################
# shellcheck disable=SC2034
{
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[0;31m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color
}
##############################################################################
#- function used to check whether an error occured
##############################################################################
function checkError() {
    # shellcheck disable=SC2181
    if [ $? -ne 0 ]; then
        echo -e "${RED}\nAn error occured exiting from the current bash${NC}"
        exit 1
    fi
}

##############################################################################
#- print functions
##############################################################################
function printMessage(){
    echo -e "${GREEN}$1${NC}" 
}
function printWarning(){
    echo -e "${YELLOW}$1${NC}" 
}
function printError(){
    echo -e "${RED}$1${NC}" 
}
function printProgress(){
    echo -e "${BLUE}$1${NC}" 
}

##############################################################################
#- azure Login 
##############################################################################
function azLogin() {
    # Check if current process's user is logged on Azure
    # If no, then triggers az login
    if [ -z "$AZURE_SUBSCRIPTION_ID" ]; then
        printError "Variable AZURE_SUBSCRIPTION_ID not set"
        az login
        # get Azure Subscription and Tenant Id if already connected
        AZURE_SUBSCRIPTION_ID=$(az account show --query id --output tsv 2> /dev/null) || true
        AZURE_TENANT_ID=$(az account show --query tenantId -o tsv 2> /dev/null) || true        
    fi
    if [ -z "$AZURE_TENANT_ID" ]; then
        printError "Variable AZURE_TENANT_ID not set"
        az login
        # get Azure Subscription and Tenant Id if already connected
        AZURE_SUBSCRIPTION_ID=$(az account show --query id --output tsv 2> /dev/null) || true
        AZURE_TENANT_ID=$(az account show --query tenantId -o tsv 2> /dev/null) || true        
    fi
    azOk=true
    az account set -s "$AZURE_SUBSCRIPTION_ID" 2>/dev/null || azOk=false
    if [[ ${azOk} == false ]]; then
        printWarning "Need to az login"
        az login --tenant "$AZURE_TENANT_ID"
    fi

    azOk=true
    az account set -s "$AZURE_SUBSCRIPTION_ID"   || azOk=false
    if [[ ${azOk} == false ]]; then
        echo -e "unknown error"
        exit 1
    fi
}

AZURE_SUBSCRIPTION_ID=""
AZURE_TENANT_ID=""
AZURE_APP_NAME=""
AZURE_APP_REDIRECT_URI=""
AZURE_RESOURCE_GROUP=""
STORAGE_ACCOUNT_NAME=""
# shellcheck disable=SC2034
while getopts "s:t:n:u:r:a:hq" opt; do
    case $opt in
    s) AZURE_SUBSCRIPTION_ID=$OPTARG ;;
    t) AZURE_TENANT_ID=$OPTARG ;;
    n) AZURE_APP_NAME=$OPTARG ;;
    u) AZURE_APP_REDIRECT_URI=$OPTARG ;;
    r) AZURE_RESOURCE_GROUP=$OPTARG ;;
    a) STORAGE_ACCOUNT_NAME=$OPTARG ;;
    :)
        echo "Error: -${OPTARG} requires a value"
        exit 1
        ;;
    *)
        usage
        exit 1
        ;;
    esac
done
# check input parameters
if [[ $# -eq 0 || -z $AZURE_SUBSCRIPTION_ID || -z $AZURE_TENANT_ID || -z $AZURE_APP_NAME || -z $AZURE_APP_REDIRECT_URI ]]; then
    echo "Required parameters are missing"
    usage
    exit 1
fi

printMessage "Create Azure AD Application..."
# Check Azure connection
printProgress "Check Azure connection for subscription: '$AZURE_SUBSCRIPTION_ID'"
azLogin
checkError
printProgress "Subscription: '$AZURE_SUBSCRIPTION_ID'"
printProgress "Tenant: '$AZURE_TENANT_ID'"

# Create or update application
cmd="az ad app list --filter \"displayName eq '${AZURE_APP_NAME}'\" -o json --only-show-errors | jq -r .[0].appId"
printProgress "$cmd"
appId=$(eval "$cmd") || true    
if [[ -z ${appId} || ${appId} == 'null' ]] ; then
    # Create application 
    printProgress "Create Application '${AZURE_APP_NAME}' "        
    cmd="az ad app create  --display-name \"${AZURE_APP_NAME}\"  --required-resource-access \"[{\\\"resourceAppId\\\": \\\"00000003-0000-0000-c000-000000000000\\\",\\\"resourceAccess\\\": [{\\\"id\\\": \\\"e1fe6dd8-ba31-4d61-89e7-88639da4683d\\\",\\\"type\\\": \\\"Scope\\\"}]},{\\\"resourceAppId\\\": \\\"e406a681-f3d4-42a8-90b6-c2b029497af1\\\",\\\"resourceAccess\\\": [{\\\"id\\\": \\\"03e0da56-190b-40ad-a80c-ea378c433f7f\\\",\\\"type\\\": \\\"Scope\\\"}]}]\" --only-show-errors | jq -r \".appId\" "
    printProgress "$cmd"
    appId=$(eval "$cmd")
    # wait 30 seconds
    printProgress "Wait 30 seconds after app creation"
    # Wait few seconds before updating the Application record in Azure AD
    sleep 30
    # Get application objectId  
    cmd="az ad app list --filter \"displayName eq '${AZURE_APP_NAME}'\" -o json --only-show-errors | jq -r .[0].id"    
    printProgress "$cmd"
    objectId=$(eval "$cmd") || true    
    if [[ -n ${objectId} && ${objectId} != 'null' ]] ; then
        printProgress "Update Application '${AZURE_APP_NAME}' in Microsoft Graph "   
        # Azure CLI Application Id : 04b07795-8ddb-461a-bbee-02f9e1bf7b46 
        # Azure CLI will be authorized to get access token to the API using the commands below:
        #  token=$(az account get-access-token --resource api://<WebAPIAppId> | jq -r .accessToken)
        #  curl -i -X GET --header "Authorization: Bearer $token"  https://<<WebAPIDomain>/visit
        cmd="az rest --method PATCH --uri \"https://graph.microsoft.com/v1.0/applications/$objectId\" \
            --headers \"Content-Type=application/json\" \
            --body \"{\\\"api\\\":{\\\"oauth2PermissionScopes\\\":[{\\\"id\\\": \\\"1619f87e-396b-48f1-91cf-9dedd9c786c8\\\",\\\"adminConsentDescription\\\": \\\"Grants full access to Visit web services APIs\\\",\\\"adminConsentDisplayName\\\": \\\"Full access to Visit API\\\",\\\"userConsentDescription\\\": \\\"Grants full access to Visit web services APIs\\\",\\\"userConsentDisplayName\\\": null,\\\"isEnabled\\\": true,\\\"type\\\": \\\"User\\\",\\\"value\\\": \\\"user_impersonation\\\"}]},\\\"spa\\\":{\\\"redirectUris\\\":[\\\"${AZURE_APP_REDIRECT_URI}\\\"]},\\\"identifierUris\\\":[\\\"api://${appId}\\\"]}\""
        printProgress "$cmd"
        eval "$cmd"
        # Wait few seconds before updating the Application record in Azure AD 
        sleep 10
        cmd="az rest --method PATCH --uri \"https://graph.microsoft.com/v1.0/applications/$objectId\" \
            --headers \"Content-Type=application/json\" \
            --body \"{\\\"api\\\":{\\\"preAuthorizedApplications\\\": [{\\\"appId\\\": \\\"04b07795-8ddb-461a-bbee-02f9e1bf7b46\\\",\\\"delegatedPermissionIds\\\": [\\\"1619f87e-396b-48f1-91cf-9dedd9c786c8\\\"]}]}}\""
        printProgress "$cmd"
        eval "$cmd"            
    else
        printError "Error while creating application ${AZURE_APP_NAME} can't get objectId"
        exit 1
    fi
    cmd="az ad app list --filter \"displayName eq '${AZURE_APP_NAME}'\" -o json --only-show-errors | jq -r .[0].appId"
    printProgress "$cmd"
    appId=$(eval "$cmd") || true    
    if [[ -n ${appId} && ${appId} != 'null' && -n ${AZURE_RESOURCE_GROUP} ]] ; then
        printProgress "Create Service principal associated with application '${AZURE_APP_NAME}' "        
        cmd="az ad sp create-for-rbac --name '${AZURE_APP_NAME}'  --role contributor --scopes /subscriptions/${AZURE_SUBSCRIPTION_ID}/resourceGroups/${AZURE_RESOURCE_GROUP} --only-show-errors"        
        printProgress "$cmd"
        eval "$cmd" || true
    fi 
    printProgress  "Application '${AZURE_APP_NAME}' with application Id: ${appId} and object Id: ${objectId} has been created"
else
    printProgress  "Application '${AZURE_APP_NAME}' with application Id: ${appId} already exists"
    printProgress  "Update application '${AZURE_APP_NAME}' with the new redirectUri ${AZURE_APP_REDIRECT_URI}"
    # Get application objectId  
    cmd="az ad app list --filter \"displayName eq '${AZURE_APP_NAME}'\" -o json --only-show-errors | jq -r .[0].id"    
    printProgress "$cmd"
    objectId=$(eval "$cmd") || true    
    if [[ -n ${objectId} && ${objectId} != 'null' ]] ; then
        printProgress "Update Application '${AZURE_APP_NAME}' in Microsoft Graph "   
        # Azure CLI Application Id : 04b07795-8ddb-461a-bbee-02f9e1bf7b46 
        # Azure CLI will be authorized to get access token to the API using the commands below:
        #  token=$(az account get-access-token --resource api://<WebAPIAppId> | jq -r .accessToken)
        #  curl -i -X GET --header "Authorization: Bearer $token"  https://<<WebAPIDomain>/visit
        cmd="az rest --method PATCH --uri \"https://graph.microsoft.com/v1.0/applications/$objectId\" \
            --headers \"Content-Type=application/json\" \
            --body \"{\\\"api\\\":{\\\"oauth2PermissionScopes\\\":[{\\\"id\\\": \\\"1619f87e-396b-48f1-91cf-9dedd9c786c8\\\",\\\"adminConsentDescription\\\": \\\"Grants full access to Visit web services APIs\\\",\\\"adminConsentDisplayName\\\": \\\"Full access to Visit API\\\",\\\"userConsentDescription\\\": \\\"Grants full access to Visit web services APIs\\\",\\\"userConsentDisplayName\\\": null,\\\"isEnabled\\\": true,\\\"type\\\": \\\"User\\\",\\\"value\\\": \\\"user_impersonation\\\"}]},\\\"spa\\\":{\\\"redirectUris\\\":[\\\"${AZURE_APP_REDIRECT_URI}\\\"]},\\\"identifierUris\\\":[\\\"api://${appId}\\\"]}\""
        printProgress "$cmd"
        eval "$cmd"
    fi
fi
printMessage "Azure AD Application creation done"

# Get Application service principal appId  
if [[ -n ${appId} && ${appId} != 'null' && -n ${AZURE_RESOURCE_GROUP} && -n ${STORAGE_ACCOUNT_NAME} ]] ; then
    printProgress  "Check 'Storage Blob Data Contributor' role assignment on scope ${STORAGE_ACCOUNT_NAME} for Application ${AZURE_APP_NAME}..."
    cmd="az role assignment list --assignee \"${appId}\" --scope /subscriptions/${AZURE_SUBSCRIPTION_ID}/resourceGroups/${AZURE_RESOURCE_GROUP}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT_NAME} --only-show-errors  | jq -r 'select(.[].roleDefinitionName==\"Storage Blob Data Contributor\") | length'"
    printProgress "$cmd"
    WebAppMsiAcrPullAssignmentCount=$(eval "$cmd") || true  
    if [ "$WebAppMsiAcrPullAssignmentCount" != "1" ];
    then
        printProgress  "Assigning 'Storage Blob Data Contributor' role assignment on scope ${STORAGE_ACCOUNT_NAME} for  appId..."
        cmd="az role assignment create --assignee \"${appId}\"  --scope /subscriptions/${AZURE_SUBSCRIPTION_ID}/resourceGroups/${AZURE_RESOURCE_GROUP}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT_NAME} --role \"Storage Blob Data Contributor\" --only-show-errors"        
        printProgress "$cmd"
        eval "$cmd"
    fi
fi
exit 0
