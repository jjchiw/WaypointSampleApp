job "demo-bz" {
  type        = "service"
  datacenters = ["dc1"]

  group "game" {
    count = 1 # number of instances

    network {
      mode = "bridge"
      port "http" {
        to = 8080
      }
    }

    service {
      name     = "demob-bz"
      // tags = [
      //   "traefik.http.routers.demo-bz.rule=Host(`demo-bz.localhost`)",
      //   "traefik.http.routers.demo-bz.entrypoints=web",
      //   "traefik.http.routers.demo-bz.tls=false",
      //   "traefik.enable=true",
      // ]

      port = "http"
      provider = "consul"
      address_mode = "alloc"

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "5s"
      }
    }

    task "demo-bz" {
      driver = "docker"

      config {
        image = "${docker_artifact.image}:${docker_artifact.tag}"

        ports = ["http"]
      }

      resources {
        cpu    = 500 # MHz
        memory = 256 # MB
      }
    }
  }
}
