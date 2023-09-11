project = "wp-bz-demo"

variable "demo_bz_docker" {
  type = object({
    image = string
    tag   = string
  })
  default = {
      image = "jjchiw/wp-blazor-demo"
      tag   = "latest"
  }
}


app "BlazorDemo" {
  build {
    // use "docker-pull" {
    //     image = var.demo_bz_docker.image
    //     tag = var.demo_bz_docker.tag
    // }
    use "docker" {
    }
    registry {
      use "docker" {
        image = "${var.demo_bz_docker.image}"
        tag   = "${var.demo_bz_docker.tag}"
      }
    }
  }

  deploy {
    use "nomad-jobspec" {
        jobspec = templatefile("${path.app}/nomad.tpl.hcl", {
            docker_artifact = "${var.demo_bz_docker}",
        })
    }

    // use "nomad" {
    //   //The following field was skipped during file generation
    //   auth = ""
    //   //The following field was skipped during file generation
    //   consul_token = ""
    //   //The following field was skipped during file generation
    //   vault_token = ""
    // }
  }
  // release {
  //   use "nomad-jobspec-canary" {
  //   }
  // }
}
