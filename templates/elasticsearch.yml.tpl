cluster:
  name: {{ getenv "ES_CLUSTER_NAME" "elasticsearch-default" }}

node:
  master: {{ getenv "ES_NODE_MASTER" "true" }}
  name: {{ getenv "ES_NODE_NAME" "true" }}
  data: {{ getenv "ES_NODE_DATA" "true" }}
  ingest: {{ getenv "ES_NODE_INGEST" "true" }}
  max_local_storage_nodes: {{ getenv "ES_NODE_MAX_LOCAL_STORAGE_NODES" "1" }}
network.host: {{ getenv "ES_NETWORK_HOST" "0.0.0.0" }}

bootstrap:
  memory_lock: {{ getenv "ES_BOOTSTRAP_MEMORY_LOCK" "true" }}

http:
  enabled: {{ getenv "ES_HTTP_ENABLED" "true" }}
  compression: {{ getenv "ES_HTTP_COMPRESSION" "true" }}
  cors:
    enabled: {{ getenv "ES_HTTP_CORS_ENABLED" "true" }}
    allow-origin: "{{ getenv "ES_HTTP_CORS_ALLOW_ORIGIN" "*" }}"

discovery:
  zen:
    minimum_master_nodes: {{ getenv "ES_DISCOVERY_ZEN_MINIMUM_MASTER_NODES" "1" }}

{{ if (getenv "ES_SHARD_ALLOCATION_AWARENESS_ATTR") }}
{{ if (getenv "ES_SHARD_ATTR") }}
node.attr.{{ getenv "ES_SHARD_ALLOCATION_AWARENESS_ATTR" }}: {{ getenv "ES_SHARD_ATTR" }}
{{ end }}

{{ $node_master := (getenv "ES_NODE_MASTER" "true") }}
{{ if (eq $node_master "true") }}
cluster.routing.allocation.awareness.attributes: {{ getenv "ES_SHARD_ALLOCATION_AWARENESS_ATTR" }}
{{ end }}
{{ end }}
