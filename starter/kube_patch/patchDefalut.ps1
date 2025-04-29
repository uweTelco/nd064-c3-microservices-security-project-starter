#Alle Namespace-Namen sammeln
$namespaces = kubectl --kubeconfig ..\kube_config_cluster.yml get namespaces -o json | ConvertFrom-Json | Select-Object -ExpandProperty items | ForEach-Object { $_.metadata.name }

# Patch-Inhalt laden
$patch = Get-Content -Raw -Path account_update.yaml

# Für jeden Namespace den Patch ausführen
foreach ($namespace in $namespaces) {
    kubectl --kubeconfig ..\kube_config_cluster.yml patch serviceaccount default -n $namespace -p "$patch"
}
