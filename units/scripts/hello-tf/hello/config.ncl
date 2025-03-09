{
  config.resource.null_resource.hello-tf-ncl = {
    provisioner.local-exec = [
      {
        command = m%"
        echo 'Hello, tf-ncl!'
        "%
      }
    ],
  },
}
