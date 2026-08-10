output "aks_id" {

  value = {

    for key, value in azurerm_kubernetes_cluster.this :

    key => value.id

  }

}

output "aks_name" {

  value = {

    for key, value in azurerm_kubernetes_cluster.this :

    key => value.name

  }

}