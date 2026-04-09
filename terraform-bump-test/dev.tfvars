##########################
# Project Information
##########################
# tenant_id       = "833df664-61c8-4af0-bcce-b9eed5f10e5a"
# subscription_id = "43e663b4-8b43-49b0-978d-949807f559b3"
tenant_id       = ""
subscription_id = ""
client_id       = ""
client_secret   = ""
project_prefix  = "opstapoc"
# location        = "southeastasia"
location    = "southeastasia"
environment = "sbx" # Deployment environment of the application, workload, or service	dev / sit / stg / prd / sbx
# -- TAG --
system_name              = "xxxx"          # Name of the workload the resource supports.	e.g. SuperDuper, Donut, MyAIS, etc
commercial_name          = "xxx"           # Commercial name of the project	e.g. Mpay One, Paruay
data_classification      = "xxx"           # Sensitivity of data hosted by this resource.	Highly Confidential / Restricted / Internal / Public
business_criticality     = "xxx"           # Business impact of the resource or supported workload.	High / Medium / Low
cost_center              = "xxx"           #Budget code (can request from administration officers of each department) (Cloud consumption) 	e.g. 00123, … 
cluster_number           = "xxx"           #Order of number which the system will be deploy	e.g. 1, 2, 3, … 
region                   = "southeastasia" # Regions of cloud provider which the resource deployed in 	e.g. southeastasia, eastasia, …
businessOwner_department = "xxx"           #Shot name of the department which business team belong to
businessOwner_section    = "xxx"           #Shot name of the section which business  team belong to
businessOwner_unit       = "xxx"           #Shot name of the unit which business  team belong to
businessOwner_name       = "xxx"           #Name of business owner
developer_department     = "xxx"           #Short name of the department which developer team belongs to	e.g. NEXT, SOL
developer_section        = "xxx"           #Short name of the section which developer team belongs to	e.g. BII / BTA / CCMA / FINE / NEXT / OCOA / RMA
developer_unit           = "xxx"           #Short name of the unit which developer team belongs to
developer_name           = "xxx"           #Name of developer owner
operation_department     = "xxx"           #Short name of the department which operation team belongs to
operation_section        = "xxx"           #Short name of the section which operation team belongs to
operation_unit           = "xxx"           #Short name of the unit which operation team belongs to
operation_name           = "xxx"           #Name of operation owner

##########################
# Hub 
##########################
# subscription_hub_id     = "d7561777-d00e-434a-9846-39c778716bde"
# hub_vnet_name           = "vnet-HubCommon-az-asse-dev-001"
# hub_vnet_resource_group = "rg-HubNetwork-az-asse-dev-001"
firewall_ip = "10.84.1.4"
# hub_bastion_cidr        = "10.84.1.64/26"
# -- Private DNS --
# private_dns_zone_resource_group = "rg-hubdnsforwarder-az-asse-dev-001"


##########################
# Hub Firewall Policy
##########################
# firewall_policy_rule_collection_group_name     = "sub-CDC-az-dev" # Use Subscription Name as rule_collection_group_name
# firewall_policy_resource_id                    = "/subscriptions/d7561777-d00e-434a-9846-39c778716bde/resourceGroups/rg-HubNetwork-az-asse-dev-001/providers/Microsoft.Network/firewallPolicies/afwp-HubFirewall-az-asse-dev-001"
# firewall_policy_rule_collection_group_priority = 1400
##########################
# Spoke Common Configuration
##########################

##########################
# Log Analytic Workspaces
##########################
retention_in_days = 90 #Days
daily_quota_gb    = 2  #GB
##########################
# Spoke Network
##########################
vnet_address                                          = ["10.84.9.0/26"]
subnet_names                                          = ["PrivateAksService", "PrivateAksCluster", "PrivateOperation", "PrivatePrivateEndpoint"]
subnet_prefixes                                       = ["10.84.9.0/28", "10.84.9.16/28", "10.84.9.32/28", "10.84.9.48/28"]
subnet_enforce_private_link_endpoint_network_policies = [false, true, false, true]
subnet_service_endpoints_list = {
  snet-PrivateOperation-az-asse-sbx-001 = ["Microsoft.Storage", ],
}
#route_tables_ids = [ "snet-PrivateOperation-az-asse-sbx-001 = azurerm_route_table.operation.id" ]

##########################
# KeyVault
##########################
network_acls_ip_rules = [
  "171.97.32.153/32",
]

##########################
# AKS
##########################
kubernetes_version                    = "1.32" # az aks get-versions --location southeastasia --output table
default_node_pool_name                = "default"
default_node_pool_vm_size             = "Standard_D2s_v3" # az vm list-skus --location southeastasia --size Standard_D2s --all --output table
default_node_pool_os_disk_type        = "Ephemeral"
default_node_pool_os_disk_size_gb     = 50              #https://docs.microsoft.com/en-us/azure/virtual-machines/dv3-dsv3-series
default_node_pool_availability_zones  = ["1", "2", "3"] #["1", "2", "3"]
default_node_pool_enable_auto_scaling = true
default_node_pool_node_count          = 1 #3
default_node_pool_min_count           = 1 #3
default_node_pool_max_count           = 1 #10

# Additional node pool configuration can be added here as needed
node_pools = {
  "devpool" = {
    mode                 = "User"
    os_type              = "Linux"
    orchestrator_version = null              # Will inherit the cluster's default version
    vm_size              = "Standard_DS2_v2" # Standard cost-effective size for dev
    vnet_subnet_id       = null
    availability_zones   = ["1"] # Reduced to a single zone to save dev costs, or use ["1", "2", "3"] for high availability
    max_count            = 2
    min_count            = 1
    node_count           = 1
    priority             = "Regular" # Could be set to "Spot" for further dev cost savings
    eviction_policy      = null
    node_labels = {
      "environment" = "dev",
      "project"     = "bookinfo"
    }
    node_taints                  = [] # Left empty so regular dev pods can schedule here without tolerations
    os_disk_size_gb              = 30
    os_disk_type                 = "Managed"
    proximity_placement_group_id = null
    tags = {
      "environment" = "dev",
      "pool"        = "dev_node_pool"
    }
  }
}


##########################
# Storage Account
##########################
account_tier             = "Standard" #account_tier = Premium ==> account_kind = BlockBlobStorage, FileStorage 
account_kind             = "StorageV2"
account_replication_type = "LRS" # LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
access_tier              = "Hot" #for account kind = BlobStorage, FileStorage and StorageV2
file_share_name          = "dev"
file_share_quota         = 50 #GB
ip_rules = [
  "171.97.32.153",
]

